"""Inventory jBC source files and check self-contained statements with Bison."""
import argparse
from collections import Counter
import csv
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile

SPEC = Path(__file__).resolve().parents[1]
NAME = r"[A-Za-z][A-Za-z0-9.$%_`]*"
NUMBER = r"(?:[0-9]+(?:\.[0-9]*)?|\.[0-9]+)"
DECL = re.compile(r"^\s*(SUBROUTINE|FUNCTION|PROGRAM)\s+" + NAME, re.I)
INCLUDE = re.compile(r"^[$#]?(?:INSERT|INCLUDE)\s+([A-Za-z0-9_.$%-]+)(?:\s*(?:;\s*(?:[*!]|REM\b).*|//.*))?$")
EQUATE = re.compile(r"^EQU(?:ATE)?\s+" + NAME + r"\s+(TO|LIT|LITERALLY)\s+" + NUMBER + r"$")
COMMENT = re.compile(r"^(?:[*!]|//|REM(?:\s|$))")
ASSIGN = re.compile(r"^(" + NAME + r")\s*(:=|\+=|-=|\*=|/=|=)")
BRANCH = re.compile(r"^(RETURN\s+TO|GO\s+TO|GOTO|GOSUB)\s+(" + NAME + r"|[0-9.]+)(:)?(?:\s*(?:;\s*(?:[*!]|REM\b).*|//.*))?$")
COMMAND = re.compile(r"^(PRINT|CRT|RETURN|STOP|NULL)(?![A-Za-z0-9.$%_`])")
LEX = re.compile(r"""\s+|'[^']*'|"[^"]*"|\\[^\\]*\\|//|;|\*\*|""" +
                 NAME + "|" + NUMBER + r"|[()\[\],+*/:=^#@!&-]")
PUNCT = {"=": "EQ", "#": "NE", "&": "AND", "!": "OR", "**": "'^'"}
ASSIGN_OP = {"=": "'='", ":=": "CE", "+=": "PE", "-=": "ME", "*=": "TE", "/=": "DE"}


def statement(line, keywords):
    """Return an isolated token sequence or None for context-dependent input."""
    branch = BRANCH.fullmatch(line)
    if branch:
        prefix = ("RETURN", "TO") if branch[1].startswith("RETURN") else (
            "GOSUB" if branch[1] == "GOSUB" else "GOTO",)
        return prefix + ("Label",) + (("':'",) if branch[3] else ())
    match = ASSIGN.match(line)
    if match and match[1] not in keywords and not match[1].endswith("_"):
        tokens = ["Identifier", ASSIGN_OP[match[2]]]
    else:
        match = COMMAND.match(line)
        if not match:
            return None
        tokens = [keywords[match[1]]]
    pos = match.end()
    while pos < len(line):
        part = LEX.match(line, pos)
        if not part:
            return None
        word = part[0]
        pos = part.end()
        if word.isspace():
            continue
        if word == "//" or (word == ";" and COMMENT.match(line[pos:].lstrip())):
            break
        if word == ";" or word.endswith("_"):
            return None
        if word[0] in "'\"\\" or word[0].isdigit() or word.startswith("."):
            token = "Constant"
        elif word[0].isalpha():
            token = keywords.get(word, "Identifier")
            if token == "Identifier" and line[pos:].lstrip().startswith("("):
                return None  # Matrix subscripts and declared functions need context.
        else:
            token = "POSCUR" if word == "@" and line[pos:].startswith("(") else PUNCT.get(word, repr(word))
        tokens.append(token)
    if tokens[-1] == "','":
        return None  # jpp joins a physical line ending in a comma.
    return tuple(tokens)


def check_shapes(shapes, grammar):
    """Compile the repository grammar, then parse each distinct token sequence."""
    if not shapes:
        return []
    with tempfile.TemporaryDirectory() as folder:
        work = Path(folder)
        subprocess.run(["bison", "-d", "-o", "parser.c", str(SPEC / grammar)],
                       cwd=work, check=True)
        header = (work / "parser.h").read_text()
        ids = dict(re.findall(r"^\s*(\w+)\s*=\s*(\d+)", header, re.M))

        def number(token):
            return str(ord(token[1])) if token.startswith("'") else ids[token]

        driver = Path(__file__).with_name("corpus_driver.c")
        subprocess.run(["cc", "-std=c99", "-I.", "-include", str(driver.with_suffix(".h")),
                        "parser.c", str(driver), "-o", "check"], cwd=work, check=True)
        data = "".join(" ".join(map(number, shape)) + " 0\n" for shape in shapes)
        output = subprocess.run([str(work / "check")], input=data, cwd=work,
                                capture_output=True, text=True, check=True).stdout.splitlines()
        if len(output) != len(shapes) or set(output) - {"pass", "reject"}:
            raise ValueError("Incomplete parser results")
        return output


def inspect(root):
    with (SPEC / "keywords.tsv").open() as source:
        keywords = {r["spelling"]: (r["token_or_function_id"] if r["lexer_class"] == "FUNC_RETKW"
                                    else r["lexer_class"]) for r in csv.DictReader(source, delimiter="\t")}
    files = Counter()
    lines = Counter()
    includes = Counter()
    shapes = Counter()
    directives = Counter()
    first = {}
    represented = 0
    by_name = Counter()
    unreadable = []
    def walk_error(error):
        raise error
    for directory, subdirs, names in os.walk(root, onerror=walk_error):
        subdirs.sort()
        for name in sorted(names):
            path = Path(directory) / name
            if path.is_symlink() or not path.is_file():
                continue
            by_name[name] += 1
            try:
                data = path.read_bytes()
            except OSError:
                unreadable.append(str(path.relative_to(root)))
                continue
            if b"\0" in data:
                files["contains NUL"] += 1
                continue
            kind = "other text"
            seen = False
            continuation = False
            for lineno, raw in enumerate(data.splitlines(), 1):
                line = raw.decode("latin1").strip()
                if not line or COMMENT.match(line):
                    lines["blank or comment"] += 1
                    continue
                decl = DECL.match(line)
                if decl and kind == "other text":
                    kind = decl[1].upper()
                inc = INCLUDE.match(line)
                if inc and not continuation:
                    includes[inc[1]] += 1
                    directives[("INCLUDE", "WORD", "EOL")] += 1
                    continue
                eq = EQUATE.fullmatch(line)
                if eq and not continuation:
                    operator = "TO" if eq[1] == "TO" else "LIT"
                    directives[("EQUATE", "WORD", operator, "WORD", "EOL")] += 1
                    continue
                shape = None if continuation else statement(line, keywords)
                continuation = line.endswith((",", "\\", "..."))
                if shape is None:
                    lines["outside statement subset"] += 1
                else:
                    shapes[shape] += 1
                    if shape not in first:
                        first[shape] = (str(path.relative_to(root)), lineno)
                    seen = True
            represented += int(seen)
            files["I_ fragment" if kind == "other text" and name.startswith("I_") else kind] += 1
    rejects = []
    for shape, result in zip(shapes, check_shapes([("EOL",) + s + ("EOL",) for s in shapes], "jbc.y")):
        lines[result] += shapes[shape]
        if result == "reject":
            file, line = first[shape]
            rejects.append(dict(tokens=" ".join(shape), occurrences=shapes[shape], file=file, line=line))
    for shape, result in zip(directives, check_shapes(directives, "preprocessor.y")):
        lines["directive " + result] += directives[shape]
    return dict(files=files, unreadable=unreadable, lines=lines, files_with_checked_statements=represented,
                distinct_token_sequences=len(shapes), simple_include_operands=len(includes),
                include_sites=sum(includes.values()), operands_matching_corpus_filename=sum(n in by_name for n in includes),
                missing_include_filenames={n: includes[n] for n in sorted(includes) if n not in by_name},
                rejected_sequences=sorted(rejects, key=lambda r: (-r["occurrences"], r["tokens"])))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path)
    args = parser.parse_args()
    if not args.directory.is_dir():
        parser.error("expected a corpus directory")
    print(json.dumps(inspect(args.directory), indent=2))
