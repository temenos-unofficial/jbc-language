# jBC Programmers Reference Guide

An unofficial reference for jBC, the Basic-like programming language of the
jBASE multi-value database, used in Temenos TAFC and TAFJ and in T24.

Read it online at **<https://jbc-lang.org/>**.

Try jBC in your browser with the [jBC Playground](https://online.jbc-lang.org/).
For native builds, see [jbcc](https://github.com/jbc-lang/jbcc), the
experimental jBC-to-C compiler.

The guide is one Markdown file,
[`jBC_Programmers_Reference_Guide.markdown`](jBC_Programmers_Reference_Guide.markdown).
This repository holds that file and the generator that turns it into the
website. Most of the text was written by
[VladimirK2](https://github.com/VladimirK2).

This is not a Temenos document and is not endorsed by Temenos. Use it at your
own risk.

## History

The guide was first published in 2012 at jbc.temenos.com, from this repository.
After that address went offline it continued at vladimirk2.github.io, where
notes on TAFJ compatibility (releases R19 to R23) were added between 2022 and
2024. In 2026 that work was brought back here and the site moved to
jbc-lang.org.

## What is in the repository

| Path | What it is |
|------|------------|
| `jBC_Programmers_Reference_Guide.markdown` | The guide. This is the file to edit. |
| [`spec/`](spec/README.md) | jBC and preprocessor grammars, lexer keywords, and function declarations cross-checked against the guide. The site draws the grammars as [railroad diagrams](#grammar-diagrams). |
| `build.py` | The site generator. |
| `site/template.html` | The HTML shell of every page: sidebar, search box, scripts. |
| `site/index.css` | The stylesheet. |
| `site/head.html` | Extra tags for the page head (analytics, search, narrow screens). |
| `site/search.js`, `site/search.css` | The full-text search. |
| `site/mobile.js`, `site/mobile.css` | The layout for narrow screens. |
| `site/footer.html` | The contact line shown under each page and the links at its top right. |
| `site/single.html` | Extra tags for the head of the single-page view. |
| `site/CNAME` | The custom domain for GitHub Pages. |
| `site/favicon.svg`, `site/favicon-32.png`, `site/apple-touch-icon.png` | The browser-tab icon. The two PNG files are made from the SVG by hand. |
| `site/llms.txt` | The opening lines of the published `llms.txt`. |
| `justfile` | Shortcuts for the commands below. |
| `skills/jbc/SKILL.md` | A skill that teaches Claude Code and Codex to answer from the guide. |
| `.github/workflows/publish.yml` | Rebuilds and publishes the site on every change. |
| `images/` | Original image files; the guide embeds its images inline. Also the project logo, `jbc-logo.svg` and `jbc-logo.png`. |
| `markdown.css` | Stylesheet of the old single-file HTML export; not used by the site. |

The built site lives on the `gh-pages` branch, not on `master`.

## Prerequisites

- **Python 3.8 or newer.** The generator uses only the standard library, so
  there is nothing to install.
- **[just](https://github.com/casey/just)**, optional. It only wraps the
  commands; each one can be run directly with `python3 build.py`.
- **git**, needed by `just check`, which fetches the published site.

## Building

```sh
just build        # or: python3 build.py
```

This writes the site to `_site/`:

- `index.html`, which redirects to the preface,
- `index.css`,
- `pages/`, one HTML file per chapter (414 at the moment),
- `all.html`, every chapter in one page (see below),
- `search.json`, `search.js` and `search.css`, the full-text search (see below),
- `mobile.js` and `mobile.css`, the layout for narrow screens (see below),
- `llms.txt`, `llms-full.txt` and `pages/*.md`, the guide as Markdown for AI
  assistants (see below).
- `grammar/jbc.html` and `grammar/preprocessor.html`, railroad diagrams of
  the grammars in `spec/` (see below).

`_site/` is ignored by git.

### Previewing while you edit

```sh
just dev          # or: python3 build.py --serve 8000
```

This serves the site at <http://localhost:8000/>, rebuilds it whenever the
guide, the template, the stylesheet or a grammar in `spec/` changes, and reloads the page in the
browser. `just dev 9000` uses another port.

### All commands

| Command | What it does |
|---------|--------------|
| `just build` | Build into `_site/`. |
| `just dev [port]` | Build, serve locally and rebuild on change. |
| `just check` | Rebuild over a copy of the published site and list the files that would change. |
| `just clean` | Delete `_site/`. |

## How the build works

`build.py` reads the guide and splits it by headings:

| In the guide | On the site |
|--------------|-------------|
| `# Title` | A group heading in the sidebar. |
| `## Title` | A chapter: one page and one sidebar link. |
| `### Title` | A section heading inside the page. |

A chapter's file name comes from its title: lower case, with spaces and
slashes turned into underscores and other punctuation dropped. `BREAK ON/OFF`
becomes `pages/break_on_off.html`, and `@FOOTER.BREAK` becomes
`pages/@footerbreak.html`. Two chapters whose titles produce the same file
name stop the build with an error.

Inside a chapter the generator understands this subset of Markdown:

- paragraphs, with `**bold**` and `*italic*`;
- lists whose items start with `- `;
- tables written with `|`;
- links to another chapter, `[READ](#READ)`, which become links to that
  chapter's page;
- images, `![alt](address)`;
- code: any block indented by four spaces is shown as jBC code with syntax
  highlighting;
- raw HTML such as `<pre>...</pre>`, which is passed through for terminal
  output that should not be highlighted.

### Syntax highlighting

The highlighter colours functions, statements, system variables, numbers,
strings and comments. It knows the functions and statements listed at the top
of `build.py` (`FUNCTIONS`, `COMMANDS`, `TYPES`). A keyword that is not in
those lists stays uncoloured, so add it there when a new example needs it.

### "Last update" dates

Every page ends with the date its text last changed. The generator does not
keep a database of dates. It reads the previous build of the page and, if the
text is the same, keeps the date that page already has. A page whose text has
changed gets the time of the build, in UTC.

On your machine the previous build is `_site/` itself. A fresh clone has none,
so a plain `just build` stamps every page with the current time. That only
affects your local copy: the published site takes its dates from the
`gh-pages` branch. To start from the published dates locally, unpack that
branch into `_site/` before the first build:

```sh
git fetch origin gh-pages
mkdir -p _site
git archive origin/gh-pages | tar -x -C _site
just build
```

### Search

The search box filters the sidebar by chapter title, as the original site did.
`site/search.js` adds a search through the text of the guide:

- under the matching titles the sidebar lists the chapters that mention the
  words, with the number of matches;
- the words are highlighted in the page, and a chapter opened from the list
  scrolls to its first match;
- Enter shows every matching chapter with the text around the match;
- the cross in the search box, or Escape, clears the search.

Several words find the chapters that contain all of them, in any order. Words
in double quotes must occur together. The match is a plain, case-insensitive
comparison of characters, so `@FM`, `MCP` or `OCONV(` are found as typed; there
is no correction of typing mistakes. Chapters whose title matches come first,
then those with the most matches.

The build writes the text of every chapter to `search.json` (about 480 KB,
140 KB compressed). The browser fetches it once, when the search box is first
used. No search library is involved.

Highlighting works within one piece of text, so a phrase that the syntax
highlighter splits into colours, such as `OCONV(`, is found but not marked in
code examples.

### Narrow screens

In a window narrower than 760 pixels, which covers phones, the page changes:

- the search box becomes a bar across the top, with a button that opens the
  list of chapters;
- the list of chapters is a panel under that bar. It also opens while the
  search box is in use, and closes when a chapter is chosen or Enter shows
  the search results;
- the text uses the full width in a larger size, wide tables scroll sideways
  and long lines of code wrap;
- the links at the top right move to the end of the page.

`site/mobile.css` holds the rules and `site/mobile.js` adds the button. The
width appears in both files.

### Single-page view

<https://jbc-lang.org/all.html> holds the whole guide in one page of about
1 MB. The search box of the site only filters chapter titles; in this page the
browser's own search finds a word anywhere in the guide. It is also the page
to print or to save for reading offline.

Every page links to it with "Single page" at the top right, and it links back
with "Chapters". Its sidebar and the links between chapters jump within the
page. It ends with one "Last update" date, that of the chapter changed most
recently. The page asks search engines not to index it, so that they keep
sending readers to the chapter pages.

### Markdown for AI assistants

The site also publishes the guide in the form proposed at
<https://llmstxt.org/>, so that a coding assistant can read it without parsing
HTML:

| Address | What it is |
|---------|------------|
| <https://jbc-lang.org/llms.txt> | An index: every chapter with a one-line summary and a link to its Markdown file. |
| <https://jbc-lang.org/llms-full.txt> | The whole guide in one file. |
| `https://jbc-lang.org/pages/<chapter>.md` | One chapter, next to its `.html` page. |

To use it, give the assistant the address of `llms.txt` and ask your question.

For Claude Code and Codex there is also a skill, `skills/jbc/SKILL.md`, which
tells the assistant how to find a chapter and to answer from the guide rather
than from memory. To install it, copy the `skills/jbc` folder into
`~/.claude/skills/` or `~/.codex/skills/`.

These files are the guide's own text with three changes: links between
chapters become full addresses, the two inline images are replaced by their
captions, and the anchors and markers that only the HTML build needs are
dropped. The summary in `llms.txt` is the first sentence of the chapter. The
opening lines of `llms.txt` come from `site/llms.txt`.

The build also writes an empty `.nojekyll` file. Without it GitHub Pages would
convert each `pages/*.md` into an HTML file with the name of the chapter page.

### Grammar diagrams

| Address | What it is |
|---------|------------|
| <https://jbc-lang.org/grammar/jbc.html> | The jBC grammar, `spec/jbc.y`. |
| <https://jbc-lang.org/grammar/preprocessor.html> | The preprocessor grammar, `spec/preprocessor.y`. |

Each rule of the grammar is drawn as a railroad diagram and written out in
EBNF. Every page links to them with "Grammar" at the top right. The build
makes them with `spec/tools/grammar_diagrams.py`, whose `GRAMMARS` list names
the pages. [spec/README.md](spec/README.md#railroad-diagrams) says how the
yacc rules are rewritten for reading. These pages have no "Last update" date.

To look at them locally, run `just dev` and open
<http://localhost:8000/grammar/jbc.html>. The page is rebuilt when a grammar,
`spec/keywords.tsv` or the generator changes. The publish workflow also runs
for changes to those files.

### Checking what a change publishes

```sh
just check
```

This fetches the `gh-pages` branch, rebuilds the site over a copy of it and
lists the files that come out different. It is what the next publish would
change:

- after editing a chapter, only that chapter's files, `all.html`, the search
  index and the Markdown files should be listed;
- after editing a grammar in `spec/`, only `grammar/*.html` should be listed;
- after a change to `build.py` that is not meant to alter the pages, nothing
  should be listed;
- a long list of `pages/*.html` means every one of those pages changes, and
  if their text changed they also get a new "Last update" date.

### Where the generator comes from

The generator was written in 2026 to reproduce the pages of the previous,
hand-published site (<https://vladimirk2.github.io/>) exactly. It was checked
against that site byte for byte until the site had moved here, and a few
oddities of the original tool remain in `build.py` for that reason. Removing
one changes the text of the pages it affects, and with it their dates.

## Publishing

Publishing is automatic. When a change to the guide, `build.py` or `site/`
reaches `master`, the workflow in `.github/workflows/publish.yml`:

1. checks out `gh-pages` as the previous build,
2. runs `python3 build.py`,
3. commits the changed pages back to `gh-pages`.

GitHub Pages serves `gh-pages` at <https://jbc-lang.org/>. The domain is set by
`site/CNAME`.

## Analytics

The documentation site loads Google Tag Manager container
`GTM-MKW38C6B`, which sends page views to GA4 measurement ID
`G-YJPRDTN9RM`. [Tag setup](site/head.html)

The tag sets the Analytics cookies `_ga` and `_ga_YJPRDTN9RM` on the
`.jbc-lang.org` domain. A browser that has visited the documentation can
also send these cookies to the playground at `online.jbc-lang.org`.

## Contributing

`master` is protected: changes arrive as pull requests and need one approval.

1. Create a branch and edit the guide.
2. Run `just dev` and check the pages you changed.
3. Open a pull request.

Some conventions for the text:

- Keep lines to about 80 characters, except in code and tables.
- Give each statement or function its own `##` chapter, with `###` sections
  such as `COMMAND SYNTAX`, `SYNTAX ELEMENTS`, `NOTES` and `EXAMPLE`.
- Indent code by four spaces or more.
- Note differences between TAFC and TAFJ in the chapter they belong to, and
  add a line to "Latest changes" in the preface.

## Contact

Questions and corrections: <info@jbc-lang.org>, or open an issue or a pull
request.
