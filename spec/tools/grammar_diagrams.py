"""Draw railroad diagrams and EBNF for the rules of a yacc grammar as one HTML page.

build.py publishes the grammars listed in GRAMMARS under grammar/ on the site.
To draw one by hand:

    python3 spec/tools/grammar_diagrams.py spec/jbc.y /tmp/jbc.html --rules program statement resultant

The page holds every rule reachable from --rules (default: the %start symbol),
in the order they are first referenced. --depth limits how far that goes.

The yacc rules are rewritten for reading, not for parsing: actions, %prec and
error recovery are dropped, left recursion becomes repetition, alternatives
that share a prefix or suffix are factored, and tiny helper rules such as
`rp : ')'` are inlined where they are used. Token names are shown by their
source spelling from keywords.tsv.
"""
import argparse
import csv
import html
from pathlib import Path
import re

SPEC = Path(__file__).resolve().parents[1]

# The pages build.py publishes: grammar file, page name, rules listed first, title.
GRAMMARS = [
    ("jbc.y", "jbc.html", ["program", "statement", "resultant"], "jBC grammar"),
    ("preprocessor.y", "preprocessor.html", None, "jBC preprocessor grammar"),
]

# Tokens whose spelling is punctuation, or which keywords.tsv does not cover.
SPELLING = {
    "EOL": "end of line", "SDYN": "<", "EDYN": ">", "LOC_SDYN": "<", "LP": "(",
    "PP": "++", "MM": "--", "PE": "+=", "ME": "-=", "TE": "*=", "DE": "/=", "CE": ":=",
    "EQ": "=", "NE": "#", "GT": ">", "LT": "<", "GE": ">=", "LE": "<=",
}
TOKEN_NOTES = {
    "EQ": "comparison: =, EQ", "NE": "comparison: #, <>, ><, NE", "GT": "comparison: >, GT",
    "LT": "comparison: <, LT", "GE": "comparison: >=, =>, GE", "LE": "comparison: <=, =<, LE",
    "SDYN": "opening bracket of a dynamic array reference such as REC<2,1>",
    "EDYN": "closing bracket of a dynamic array reference",
    "LOC_SDYN": "opening bracket of a dynamic array reference in LOCATE or DEL",
    "LP": "opening parenthesis of a matrix assignment",
    "Identifier": "a variable or other name",
    "Constant": "a number or a string literal",
    "Label": "a statement label",
    "CFUNC": "a name declared earlier with DEFC",
    "BFUNC": "a name declared earlier with DEFFUN",
}

# ---------------------------------------------------------------- reading


def read_grammar(path):
    text = re.sub(r"/\*.*?\*/", " ", path.read_text(), flags=re.S)
    head, body = text.split("%%", 2)[:2]
    tokens = {line.split()[1] for line in head.splitlines() if line.startswith("%token")}
    precedence = [(m.group(1), m.group(2).split())
                  for m in re.finditer(r"^%(left|right|nonassoc)\s+(.*)$", head, re.M)]
    start = re.search(r"^%start\s+(\w+)", head, re.M)
    rules, sources = {}, {}
    for m in re.finditer(r"^(\w+)\s*\n(\s*:.*?)\n\s*;[ \t]*$", body, re.M | re.S):
        name, rhs = m.group(1), m.group(2)
        sources[name] = name + "\n" + rhs + "\n    ;"
        # Drop actions, but not the quoted tokens '{' and '}'.
        rhs = re.sub(r"'[^']*'|\{[^{}]*\}", lambda m: m.group(0) if m.group(0)[0] == "'" else " ", rhs)
        rhs = rhs.strip()[1:]
        words = re.findall(r"'[^']*'|%prec|\w+|\|", rhs)
        alts, cur, skip = [], [], False
        for word in words:
            if skip:
                skip = False
            elif word == "%prec":
                skip = True
            elif word == "|":
                alts.append(cur)
                cur = []
            else:
                cur.append(word)
        alts.append(cur)
        rules[name] = [a for a in alts if "error" not in a]
    return tokens, precedence, start.group(1) if start else next(iter(rules)), rules, sources


def read_keywords(path):
    spellings = {}
    with path.open() as f:
        for row in csv.DictReader(f, delimiter="\t"):
            cls = row["lexer_class"]
            token = row["token_or_function_id"] if cls == "FUNC_RETKW" else cls
            spellings.setdefault(token, []).append(row["spelling"])
    return spellings

# ---------------------------------------------------------------- rewriting
# Nodes are hashable tuples: ("t", token) ("n", rule) ("seq", items)
# ("alt", items) ("opt", node) ("star", node) ("plus", node) ("eps",)

EPS = ("eps",)


def seq(items):
    flat = []
    for item in items:
        if item == EPS:
            continue
        flat.extend(item[1] if item[0] == "seq" else [item])
    if not flat:
        return EPS
    return flat[0] if len(flat) == 1 else ("seq", tuple(flat))


def alt(items):
    flat, optional = [], False
    for item in items:
        if item == EPS:
            optional = True
        elif item[0] == "alt":
            flat.extend(i for i in item[1] if i not in flat)
        elif item[0] == "opt":
            optional = True
            flat.append(item[1])
        elif item not in flat:
            flat.append(item)
    node = EPS if not flat else flat[0] if len(flat) == 1 else ("alt", tuple(flat))
    return ("opt", node) if optional and node != EPS else node


def common(seqs, reverse=False):
    n = 0
    shortest = min(len(s) for s in seqs)
    while n < shortest and len({s[-1 - n] if reverse else s[n] for s in seqs}) == 1:
        n += 1
    return n


def factor(alts):
    """Turn a list of alternatives (lists of nodes) into one node."""
    groups = {}
    for a in alts:
        groups.setdefault(a[0] if a else EPS, []).append(list(a))
    items = []
    for key, group in groups.items():
        unique = [list(g) for g in dict.fromkeys(tuple(g) for g in group)]
        if key == EPS or len(unique) == 1:
            items.append(seq(unique[0]))
            continue
        p = common(unique)
        rests = [g[p:] for g in unique]
        s = common(rests, reverse=True) if all(rests) else 0
        middles = [r[:len(r) - s] for r in rests]
        items.append(seq(unique[0][:p] + [factor(middles)] + (rests[0][len(rests[0]) - s:] if s else [])))
    # `'+' resultant | '-' resultant` -> `('+' | '-') resultant`
    by_last, merged = {}, []
    for item in items:
        if item[0] == "seq" and len(item[1]) == 2 and item[1][0][0] == "t":
            by_last.setdefault(item[1][1], []).append(item[1][0])
    done = set()
    for item in items:
        if item[0] == "seq" and len(item[1]) == 2 and len(by_last.get(item[1][1], ())) > 1:
            last = item[1][1]
            if last not in done:
                done.add(last)
                merged.append(seq([alt(by_last[last]), last]))
        else:
            merged.append(item)
    return alt(merged)


class Grammar:
    def __init__(self, tokens, rules, keep):
        self.tokens, self.rules, self.keep = tokens, rules, set(keep)
        self.memo = {}
        self.inline = {name for name in rules if self.inlinable(name)}

    def terminal(self, word):
        return word.startswith("'") or word in self.tokens

    def inlinable(self, name):
        alts = self.rules[name]
        if name in self.keep or any(name in a for a in alts):
            return False
        if all(all(self.terminal(w) for w in a) for a in alts):
            return len(alts) <= 3 and all(len(a) <= 2 for a in alts)
        return len(alts) == 2 and [] in alts and max(len(a) for a in alts) <= 3

    def symbol(self, word):
        if self.terminal(word):
            return ("t", word)
        if word in self.inline:
            return self.node(word)
        return ("n", word)

    def node(self, name):
        if name not in self.memo:
            alts = self.rules[name]
            loops = [[self.symbol(w) for w in a[1:]] for a in alts if a[:1] == [name]]
            bases = [[self.symbol(w) for w in a] for a in alts if a[:1] != [name]]
            if not loops:
                result = factor(bases)
            else:
                base, loop = factor(bases), factor(loops)
                if base == EPS:
                    result = ("star", loop)
                elif base == loop:
                    result = ("plus", loop)
                else:
                    result = seq([base, ("star", loop)])
            self.memo[name] = result
        return self.memo[name]


def references(node, out):
    if node[0] == "n":
        out.append(node[1])
    elif node[0] in ("seq", "alt"):
        for item in node[1]:
            references(item, out)
    elif node[0] in ("opt", "star", "plus"):
        references(node[1], out)
    return out

# ---------------------------------------------------------------- drawing

AR, VS, GAP, CH, BH = 10, 8, 10, 7.2, 22


def line(x1, y, x2):
    return f'<path d="M{x1:g} {y:g}H{x2:g}"/>' if x2 != x1 else ""


class Box:
    def __init__(self, text, kind, href=None, title=None):
        self.text, self.kind, self.href, self.title = text, kind, href, title
        self.w, self.up, self.down = len(text) * CH + 20, BH / 2, BH / 2

    def draw(self, x, y):
        rx = 0 if self.kind.startswith("nt") else BH / 2
        title = f"<title>{html.escape(self.title)}</title>" if self.title else ""
        body = (f'<g class="{self.kind}">{title}<rect x="{x:g}" y="{y - BH / 2:g}" width="{self.w:g}" '
                f'height="{BH}" rx="{rx}"/><text x="{x + self.w / 2:g}" y="{y + 4:g}">'
                f"{html.escape(self.text)}</text></g>")
        return f'<a href="{self.href}">{body}</a>' if self.href else body


class Skip:
    w = up = down = 0

    def draw(self, x, y):
        return ""


class Seq:
    def __init__(self, items):
        self.items = items
        self.w = sum(i.w for i in items) + GAP * (len(items) - 1)
        self.up = max(i.up for i in items)
        self.down = max(i.down for i in items)

    def draw(self, x, y):
        out = []
        for n, item in enumerate(self.items):
            out.append(item.draw(x, y))
            x += item.w
            if n < len(self.items) - 1:
                out.append(line(x, y, x + GAP))
                x += GAP
        return "".join(out)


class Choice:
    def __init__(self, items):
        self.items = items
        self.w = max(i.w for i in items) + 4 * AR
        self.ys = [0]
        for prev, item in zip(items, items[1:]):
            self.ys.append(max(self.ys[-1] + prev.down + VS + item.up, 2 * AR))
        self.up, self.down = items[0].up, self.ys[-1] + items[-1].down

    def draw(self, x, y):
        out, end = [], x + self.w
        for item, dy in zip(self.items, self.ys):
            ly = y + dy
            if dy == 0:
                out.append(line(x, y, x + 2 * AR) + line(end - 2 * AR, y, end))
            else:
                out.append(f'<path d="M{x:g} {y:g}a{AR} {AR} 0 0 1 {AR} {AR}V{ly - AR:g}'
                           f'a{AR} {AR} 0 0 0 {AR} {AR}"/>')
                out.append(f'<path d="M{end - 2 * AR:g} {ly:g}a{AR} {AR} 0 0 0 {AR} {-AR}'
                           f'V{y + AR:g}a{AR} {AR} 0 0 1 {AR} {-AR}"/>')
            out.append(item.draw(x + 2 * AR, ly))
            out.append(line(x + 2 * AR + item.w, ly, end - 2 * AR))
        return "".join(out)


class Loop:
    def __init__(self, item):
        self.item = item
        self.w = item.w + 2 * AR
        self.up = item.up
        self.down = max(item.down + VS, 2 * AR)

    def draw(self, x, y):
        end, ly = x + self.w, y + self.down
        return (line(x, y, x + AR) + self.item.draw(x + AR, y) + line(x + AR + self.item.w, y, end)
                + f'<path class="back" d="M{end - AR:g} {y:g}a{AR} {AR} 0 0 1 {AR} {AR}V{ly - AR:g}'
                f'a{AR} {AR} 0 0 1 {-AR} {AR}H{x + AR:g}a{AR} {AR} 0 0 1 {-AR} {-AR}V{y + AR:g}'
                f'a{AR} {AR} 0 0 1 {AR} {-AR}"/>'
                f'<path class="arrow" d="M{x + self.w / 2 + 3:g} {ly - 4:g}l-6 4l6 4"/>')


class Renderer:
    def __init__(self, tokens, keywords, shown):
        self.tokens, self.keywords, self.shown = tokens, keywords, shown

    def token(self, word):
        """Return (display text, css kind, tooltip) for a terminal."""
        if word.startswith("'"):
            return word[1:-1], "punct", None
        spellings = self.keywords.get(word, [])
        if word in SPELLING:
            return SPELLING[word], "punct", TOKEN_NOTES.get(word, word)
        if word.startswith(("FUNC_", "ENVFUNC")) or word in TOKEN_NOTES or not word.isupper():
            note = TOKEN_NOTES.get(word, "")
            if spellings:
                note = f"{len(spellings)} built-ins: " + ", ".join(sorted(spellings))
            return word, "cls", note or word
        if spellings:
            return " / ".join(sorted(spellings)), "kw", f"token {word}"
        return word[4:] if word.startswith("JAC_") else word, "kw", f"token {word}"

    def distinct(self, items):
        """Drop alternatives that look the same, such as EQ and '=' which both show as =."""
        seen, out = set(), []
        for item in items:
            key = plain(self.ebnf(item))
            if key not in seen:
                seen.add(key)
                out.append(item)
        return out

    def layout(self, node):
        kind = node[0]
        if kind == "t":
            text, css, title = self.token(node[1])
            return Box(text, css, title=title)
        if kind == "n":
            if node[1] in self.shown:
                return Box(node[1], "nt", href=f"#{node[1]}")
            return Box(node[1], "nt off", title="not drawn on this page")
        if kind == "seq":
            return Seq([self.layout(i) for i in node[1]])
        if kind == "alt":
            return Choice([self.layout(i) for i in self.distinct(node[1])])
        if kind == "opt":
            return Choice([Skip(), self.layout(node[1])])
        if kind == "plus":
            return Loop(self.layout(node[1]))
        if kind == "star":
            return Choice([Skip(), Loop(self.layout(node[1]))])
        return Skip()

    def svg(self, node):
        body = self.layout(node)
        pad = 12
        width, height = body.w + 2 * pad + 20, body.up + body.down + 2 * pad
        y = pad + body.up
        x0 = pad + 10
        return (f'<svg class="rr" width="{width:g}" height="{height:g}" viewBox="0 0 {width:g} {height:g}">'
                f'<path d="M{pad:g} {y - 7:g}v14M{pad + 4:g} {y - 7:g}v14"/>{line(pad + 4, y, x0)}'
                f'{body.draw(x0, y)}{line(x0 + body.w, y, x0 + body.w + 6)}'
                f'<path d="M{x0 + body.w + 6:g} {y - 7:g}v14M{x0 + body.w + 10:g} {y - 7:g}v14"/></svg>')

    def ebnf(self, node, ctx=None, ind=""):
        """Return EBNF as HTML; long alternatives are broken over lines at indent `ind`."""
        kind = node[0]
        if kind == "t":
            text, css, title = self.token(node[1])
            t = f' title="{html.escape(title)}"' if title else ""
            if css == "cls":
                return f'<span class="cls"{t}>{html.escape(text)}</span>'
            words = [f"<span class=\"{css}\"{t}>'{html.escape(w)}'</span>" for w in text.split(" / ")]
            return words[0] if len(words) == 1 else "( " + " | ".join(words) + " )"
        if kind == "n":
            name = node[1]
            if name in self.shown:
                return f'<a href="#{name}">{name}</a>'
            return f'<span class="off">{name}</span>'
        if kind == "seq":
            text = " ".join(self.ebnf(i, "seq", ind) for i in node[1])
            return f"( {text} )" if ctx == "post" else text
        if kind == "alt":
            parts = [self.ebnf(i, "alt", ind + "  ") for i in self.distinct(node[1])]
            flat = " | ".join(parts)
            simple = all(i[0] == "t" for i in node[1])
            if "\n" not in flat and (simple or len(plain(flat)) <= 90):
                return f"( {flat} )" if ctx in ("seq", "post") else flat
            body = f"\n{ind}| ".join(parts)
            return f"( {body}\n{ind})" if ctx in ("seq", "post") else body
        suffix = {"opt": "?", "star": "*", "plus": "+"}[kind]
        return self.ebnf(node[1], "post", ind) + suffix

    def ebnf_rule(self, name, node):
        text = self.ebnf(node, "alt", "    ")
        if "\n" not in text and len(plain(text)) + len(name) <= 100:
            return f"{name} ::= {text}"
        return f"{name}\n    ::= {text}".replace("\n    | ", "\n     | ") if node[0] == "alt" else \
            f"{name}\n    ::= {text}"


def plain(text):
    return html.unescape(re.sub(r"<[^>]+>", "", text))


# ---------------------------------------------------------------- page

CSS = """
:root{--bg:#fff;--fg:#1d2430;--muted:#6a7380;--line:#3a4656;--kw:#e7f0ff;--kwb:#3567b5;
--punct:#fff4dc;--punctb:#a8761d;--cls:#f1f1f1;--nt:#e9f7ee;--ntb:#2c7a4b;--code:#f6f7f9;--rule:#e3e6ea}
@media (prefers-color-scheme:dark){:root{--bg:#15181d;--fg:#e3e7ec;--muted:#98a2ae;--line:#aab4c0;
--kw:#1d2c45;--kwb:#7ea6e8;--punct:#3a2f17;--punctb:#d9a94a;--cls:#262a30;--nt:#17321f;--ntb:#6cc790;
--code:#1c2026;--rule:#2b3038}}
body{background:var(--bg);color:var(--fg);font:15px/1.5 system-ui,sans-serif;margin:0 auto;max-width:1100px;padding:24px 16px 80px}
h1{font-size:26px;margin:0 0 4px}h2{font-size:19px;margin:40px 0 8px;font-family:ui-monospace,monospace}
p.lead{color:var(--muted);margin:0 0 20px}
.legend{display:flex;flex-wrap:wrap;gap:8px 18px;align-items:center;font-size:13px;color:var(--muted)}
.diagram{overflow-x:auto;border:1px solid var(--rule);border-radius:8px;padding:6px 4px;margin:8px 0}
svg.rr{display:block}svg.rr path{fill:none;stroke:var(--line);stroke-width:1.5}
svg.rr path.arrow{stroke-width:1.5}
svg.rr text{font:12px ui-monospace,SFMono-Regular,Menlo,monospace;text-anchor:middle;fill:var(--fg)}
svg.rr rect{stroke-width:1.5}
.kw rect{fill:var(--kw);stroke:var(--kwb)}.kw text{font-weight:600}
.punct rect{fill:var(--punct);stroke:var(--punctb)}
.cls rect{fill:var(--cls);stroke:var(--line);stroke-dasharray:4 3}.cls text{font-style:italic}
.nt rect{fill:var(--nt);stroke:var(--ntb)}a .nt:hover rect{stroke-width:2.5}
.nt.off rect{fill:var(--bg);stroke:var(--muted)}.nt.off text{fill:var(--muted)}
pre{background:var(--code);border-radius:8px;padding:12px 14px;overflow-x:auto;font-size:12.5px;line-height:1.6}
pre a{color:var(--ntb);font-weight:600}pre .kw{color:var(--kwb)}pre .punct{color:var(--punctb)}
pre .cls{font-style:italic;color:var(--muted)}pre .off{color:var(--muted)}
.meta{font-size:13px;color:var(--muted)}.meta a{color:var(--ntb)}
details{margin-top:6px}summary{cursor:pointer;font-size:13px;color:var(--muted)}
table{border-collapse:collapse;font-size:14px}td,th{border-bottom:1px solid var(--rule);padding:4px 12px;text-align:left}
code{font-family:ui-monospace,monospace}
.top{font-size:13px;color:var(--muted);margin-bottom:14px}.top a{color:var(--ntb)}
nav{font-size:14px;margin:12px 0}nav a{color:var(--ntb);margin-right:10px;font-family:ui-monospace,monospace}
"""


def legend():
    samples = [Box("FOR", "kw"), Box("(", "punct"), Box("Identifier", "cls"), Box("resultant", "nt"),
               Box("ident_options", "nt off")]
    words = ["keyword", "punctuation or operator", "token class (hover for members)",
             "rule (click)", "rule not in this page"]
    parts = []
    for box, word in zip(samples, words):
        parts.append(f'<span><svg class="rr" width="{box.w + 4:g}" height="26">{box.draw(2, 13)}</svg></span>'
                     f"<span>{word}</span>")
    return '<div class="legend">' + "".join(parts) + "</div>"


def precedence_table(renderer, precedence):
    rows = []
    for level, (assoc, words) in enumerate(reversed(precedence), 1):
        ops = " ".join(html.escape(renderer.token(w)[0]) for w in words if w not in ("Constant", "Identifier"))
        if ops:
            rows.append(f"<tr><td>{level}</td><td>{assoc}</td><td><code>{ops}</code></td></tr>")
    return ("<table><tr><th>Binds</th><th>Associativity</th><th>Tokens</th></tr>" + "".join(rows)
            + "</table><p class=meta>Level 1 binds tightest. Taken from the %left, %right and %nonassoc "
            "declarations of the grammar.</p>")


def diagrams(renderer, node):
    """Draw a rule; `X (Y)*` with a large X is drawn as two diagrams so the loop stays in view."""
    if node[0] == "seq" and len(node[1]) == 2 and node[1][0][0] == "alt" and node[1][1][0] == "star":
        head, tail = node[1]
        return (f'<p class="meta">Starts with one of:</p><div class="diagram">{renderer.svg(head)}</div>'
                f'<p class="meta">Then any number of:</p><div class="diagram">{renderer.svg(tail)}</div>')
    return f'<div class="diagram">{renderer.svg(node)}</div>'


def render(path, rules=None, title=None, depth=None, links=""):
    """Return the HTML page for the grammar at `path`.

    `rules` are drawn first and listed at the top (default: the %start
    symbol); every rule reachable from them follows, at most `depth`
    references away. `links` is HTML put above the heading.
    """
    path = Path(path)
    tokens, precedence, start, rules_by_name, sources = read_grammar(path)
    top = list(rules or [start])
    keywords = read_keywords(SPEC / "keywords.tsv")
    grammar = Grammar(tokens, rules_by_name, top)
    nodes = {name: grammar.node(name) for name in rules_by_name if name not in grammar.inline}

    shown, frontier, level, depth_limit = list(top), list(top), 0, depth
    while frontier and (depth_limit is None or level < depth_limit):
        nxt = []
        for name in frontier:
            for ref in references(nodes[name], []):
                if ref not in shown and ref not in nxt:
                    nxt.append(ref)
        shown += nxt
        frontier, level = nxt, level + 1
    # Follow rules that only name other rules, such as program -> section -> statements.
    for name in shown:
        node = nodes[name]
        if all(item[0] == "n" for item in (node[1] if node[0] == "seq" else [node])):
            shown += [r for r in dict.fromkeys(references(node, [])) if r not in shown]
    used_by = {}
    for name, node in nodes.items():
        for ref in references(node, []):
            used_by.setdefault(ref, set()).add(name)

    renderer = Renderer(tokens, keywords, set(shown))
    sections = []
    for name in shown:
        users = sorted(used_by.get(name, ()))
        user_links = ", ".join(f'<a href="#{u}">{u}</a>' if u in renderer.shown else u for u in users)
        sections.append(
            f'<section id="{name}"><h2>{name}</h2>'
            f"{diagrams(renderer, nodes[name])}"
            f"<pre>{renderer.ebnf_rule(name, nodes[name])}</pre>"
            f'<div class="meta">Used by: {user_links or "start symbol"}</div>'
            f"<details><summary>yacc source</summary><pre>{html.escape(sources[name])}</pre></details>"
            "</section>")
        if name == top[-1] and len(shown) > len(top):
            sections.append('<h2 style="font-family:inherit">Other rules</h2>'
                            f'<p class=meta>Rules used by {", ".join(top)}, in the order they are first referenced.</p>')

    title = title or f"{path.stem} grammar"
    inlined = ", ".join(sorted(grammar.inline))
    try:
        source = path.resolve().relative_to(SPEC.parent).as_posix()
    except ValueError:
        source = path.name
    page = f"""<!doctype html><html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1"><title>{html.escape(title)}</title>
<style>{CSS}</style></head><body>
{f'<div class="top">{links}</div>' if links else ""}
<h1>{html.escape(title)}: railroad diagrams</h1>
<p class="lead">Generated from <code>{source}</code> by <code>spec/tools/grammar_diagrams.py</code>; do not edit.
Diagrams read left to right; a track that turns back is a repetition.</p>
{legend()}
<nav>{" ".join(f'<a href="#{n}">{n}</a>' for n in top)} <a href="#precedence">precedence</a></nav>
<details><summary>How the yacc rules were rewritten</summary><p class="meta">Actions, <code>%prec</code> and
<code>error</code> alternatives are dropped. Left recursion such as <code>eols : EOL | eols EOL</code> becomes
repetition. Alternatives that share a first or last symbol are factored. These one-line rules are drawn inline
where they are used: {inlined}. The diagrams describe the token stream after jpp and the lexer, so ambiguity
that the yacc precedence declarations resolve is not shown; see the table below.</p></details>
{"".join(sections)}
<section id="precedence"><h2>precedence</h2>{precedence_table(renderer, precedence)}</section>
</body></html>
"""
    stats = f"{len(shown)} rules drawn, {len(grammar.inline)} inlined, {len(rules_by_name)} in the grammar"
    return page, stats


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("grammar", type=Path, help="a yacc grammar such as spec/jbc.y")
    ap.add_argument("out", type=Path, help="the HTML file to write")
    ap.add_argument("--rules", nargs="+", help="rules to draw first and list at the top")
    ap.add_argument("--depth", type=int, help="draw rules at most this many references away")
    ap.add_argument("--title", help="page heading (default: from the grammar file name)")
    args = ap.parse_args()
    page, stats = render(args.grammar, args.rules, args.title, args.depth)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(page, encoding="utf-8")
    print(f"{args.out}: {stats}")


if __name__ == "__main__":
    main()
