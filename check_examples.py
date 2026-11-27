#!/usr/bin/env python3
"""Find the guide's code blocks that the playground can run.

Reads the chapter pages that build.py wrote to _site/, takes every code
block the way site/content.js reads it, and builds and runs each one with
jbcc, the jBC compiler that the playground at online.jbc-lang.org runs in
the browser. Each block goes first through jbcc's browser translator, which
refuses what the playground cannot do (files, EXECUTE, terminal control),
then through a native build and run. The blocks that build, print something and exit with status 0
within five seconds are written to site/runnable.txt, which build.py turns into the
"Run" buttons.

Not part of the build: it needs uv (for `uvx`) and a C compiler for jbcc.
Run it with `just examples` after changing the guide's code, and when the
playground moves to another jbcc version.

Standard library only, like build.py.
"""

import argparse
import html
import json
import os
import re
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path(__file__).resolve().parent
# Keep in step with `version` in jbc-playground/jbcc-wheel.mjs.
JBCC_VERSION = "0.3.0"
RUN_SECONDS = 5

CONTENT_RE = re.compile(r'<div id="content">(.*?)<div id="timestamp">', re.S)
PRE_RE = re.compile(r"<pre[^>]*>(.*?)</pre>", re.S)
LINE_RE = re.compile(r"<span>(.*?)</span>(?=<span>|$)", re.S)
TAG_RE = re.compile(r"<[^>]+>")


def fnv1a(text):
    """32-bit FNV-1a of the UTF-8 text, as 8 hex digits; content.js has the
    same function."""
    value = 0x811C9DC5
    for byte in text.encode("utf-8"):
        value = ((value ^ byte) * 0x01000193) & 0xFFFFFFFF
    return "%08x" % value


def code_text(inner):
    """The text of a code block as content.js's codeText() gives it: the
    lines without the indent they share and without trailing spaces."""
    spans = LINE_RE.findall(inner)
    text = [html.unescape(TAG_RE.sub("", span)) for span in spans] or [html.unescape(TAG_RE.sub("", inner))]
    # A <span> holds one line with its newline; text outside spans is split.
    lines = [line for chunk in text for line in (chunk[:-1] if chunk.endswith("\n") else chunk).split("\n")]
    shared = min((len(line) - len(line.lstrip(" ")) for line in lines if line.strip()), default=0)
    text = "\n".join(line[shared:].rstrip() for line in lines)
    return text.strip("\n") + "\n"


def blocks(site):
    """(chapter file name, code) for every code block with some text."""
    for page in sorted((site / "pages").glob("*.html")):
        content = CONTENT_RE.search(page.read_text(encoding="utf-8"))
        for match in PRE_RE.finditer(content.group(1) if content else ""):
            code = code_text(match.group(1))
            if code.strip():
                yield page.stem, code


def has_statements(code):
    """False for a block of only comments, such as the output of an example
    written as comments."""
    return any(line.strip() and not line.lstrip().startswith(("*", "!")) for line in code.splitlines())


# Runs inside jbcc's environment: translates each block with jbcc.browser,
# the API the playground calls, which refuses what a browser cannot do
# (EXECUTE, OPENSEQ, terminal cursor control and so on). Reads a JSON list of
# sources, prints the list of those that translate.
BROWSER_GATE = """
import json, os, sys, tempfile
from contextlib import redirect_stderr
from io import StringIO
from pathlib import Path
from jbcc.browser import translate
passed = []
with tempfile.TemporaryDirectory() as work:
    os.chdir(work)
    for n, code in enumerate(json.load(sys.stdin)):
        path = Path("b%d.b" % n)
        path.write_text(code, encoding="utf-8")
        try:
            with redirect_stderr(StringIO()):
                translate([path], include_resolver=lambda *_: None, include_depth=16)
            passed.append(code)
        except Exception:
            pass
json.dump(passed, sys.stdout)
"""


def browser_translates(codes):
    """The codes that the playground's translator accepts."""
    gate = subprocess.run(
        ["uvx", "--from", "jbcc==%s" % JBCC_VERSION, "python", "-c", BROWSER_GATE],
        input=json.dumps(codes), capture_output=True, text=True, check=True,
    )
    return set(json.loads(gate.stdout))


def check(jbcc, work, code):
    """True if jbcc builds the code and the program prints something and
    exits with status 0. A program that prints nothing, such as "CLEAR"
    alone, shows nothing in the playground either."""
    if not has_statements(code):
        return False
    name = fnv1a(code)
    source = work / (name + ".b")
    program = work / name
    source.write_text(code, encoding="utf-8")
    try:
        built = subprocess.run([jbcc, "--exe", str(source), "-o", str(program)], capture_output=True, timeout=120)
        if built.returncode:
            return False
        # In the temporary directory: some examples write files.
        ran = subprocess.run(
            [str(program)], cwd=str(work), stdin=subprocess.DEVNULL, capture_output=True, timeout=RUN_SECONDS
        )
        return ran.returncode == 0 and ran.stdout.strip() != b""
    except subprocess.TimeoutExpired:
        return False


def main():
    parser = argparse.ArgumentParser(description="Find the guide's code blocks that the playground can run.")
    parser.add_argument("--site", type=Path, default=ROOT / "_site", help="the built site (default: _site)")
    parser.add_argument("--out", type=Path, default=ROOT / "site" / "runnable.txt")
    parser.add_argument("--report", type=Path, help="also write every block's result to this JSON file")
    args = parser.parse_args()

    found = list(blocks(args.site))
    if not found:
        raise SystemExit("No code blocks in %s; run `just build` first." % args.site)
    where = subprocess.run(
        ["uvx", "--from", "jbcc==%s" % JBCC_VERSION, "python", "-c", "import shutil; print(shutil.which('jbcc'))"],
        capture_output=True, text=True, check=True,
    )
    jbcc = where.stdout.strip()

    unique = sorted({code for _, code in found if has_statements(code)})
    # The browser translator decides what the playground accepts; a native
    # build of the same code then shows whether it runs and prints.
    accepted = sorted(browser_translates(unique))
    results = dict.fromkeys((code for _, code in found), False)
    with tempfile.TemporaryDirectory() as work, ThreadPoolExecutor(os.cpu_count()) as pool:
        results.update(zip(accepted, pool.map(lambda code: check(jbcc, Path(work), code), accepted)))

    runnable = {}
    for slug, code in found:
        if results[code]:
            runnable.setdefault(slug, [])
            if fnv1a(code) not in runnable[slug]:
                runnable[slug].append(fnv1a(code))
    lines = [
        "# Code blocks that jbcc %s, the playground's compiler, builds and runs" % JBCC_VERSION,
        "# prints something and exits with status 0: <chapter file name> <hashes>.",
        "# Written by check_examples.py (`just examples`); do not edit by hand.",
    ] + ["%s %s" % (slug, " ".join(runnable[slug])) for slug in sorted(runnable)]
    args.out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    if args.report:
        report = [{"chapter": slug, "hash": fnv1a(code), "runs": results[code], "code": code} for slug, code in found]
        args.report.write_text(json.dumps(report, indent=1), encoding="utf-8")
    total = sum(len(hashes) for hashes in runnable.values())
    print("%d code blocks, %d runnable in %d chapters; wrote %s" % (len(found), total, len(runnable), args.out))


if __name__ == "__main__":
    sys.exit(main())
