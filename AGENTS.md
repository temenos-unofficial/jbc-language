# Notes for coding agents

Read `README.md` first for what the repository holds and how the site is
built. This file covers the constraints that are easy to break.

## Layout and scope

- The guide is one file, `jBC_Programmers_Reference_Guide.markdown`. Do not
  change its text unless the task is about the text; most of it was written by
  another author. Text conventions are in README "Contributing".
- `build.py` is the whole generator, apart from the grammar diagrams it loads
  from `spec/tools/grammar_diagrams.py`. It uses only the Python standard library
  and must keep running on Python 3.8. Do not add dependencies, a package
  manager or a JavaScript build step.
- `site/` holds the files the generator reads. `_site/` is the build output and
  is not tracked.
- The `gh-pages` branch is build output, written by the publish workflow. Never
  commit to it by hand.
- `skills/jbc/SKILL.md` is a skill for Claude Code and Codex that reads the
  published site. It is not used by the build.

## The published site is the reference

`just check` fetches `gh-pages`, rebuilds over a copy of it and lists the
files that come out different: what the next publish would change. It needs
network access. Run it for every change to `build.py` or `site/`, and compare
the list with what the change was meant to do.

- Several things in `build.py` look like bugs and are left over from the tool
  this generator replaced: `&gt` without a semicolon in code, emphasis left
  alone on some lines, every line of a list block becoming an item, the
  fallback for a mistyped anchor.
  Fixing one changes the text of every page it touches, and so their dates.
  Do it only when asked.
- `site/template.html` and `site/index.css` came from the original site and
  were frozen until the comparison with it was retired. They can be edited
  now. The search, the narrow-screen layout and the single-page view still
  live in their own files and are loaded through `site/head.html`.

## "Last update" dates

A page keeps its date only while its rendered text is unchanged; the previous
build is the only record (README "Last update dates").

- A change to what `render_content` or `highlight` produce gives every affected
  page today's date on the next publish. Avoid it unless that is the intent,
  and say so in the pull request.
- The head, the footer, the sidebar and the pager (`<nav id="pager">`,
  which `split_page` strips) are outside the compared text, so changing
  them does not touch the dates.
- Locally a fresh clone has no previous build. To see real dates, unpack
  `gh-pages` into `_site/` first, as README shows.

## Checking a change

There are no unit tests. A change to the build is checked with:

1. `just build` twice: the second run must report `0 files changed`.
2. `just check`: the list is what the change was meant to alter, and
   `0 files changed` when it was not meant to alter the pages.
3. `just dev 18765` and a look at the pages in a browser, for anything visible.
   Use a high port; 8000 is often taken.

## Things that are connected

- **Chapter file names.** `slugify` decides them. The same names are used by
  the chapter pages, the `.md` files, `llms.txt`, `search.json`, the anchors in
  `all.html` and the rule described in `skills/jbc/SKILL.md` and in the README.
  Change them together, and remember that published addresses are linked from
  elsewhere.
- **Absolute addresses.** The pages use `/search.js`, `/all.html` and
  `/llms.txt`. The site is served from the root of its domain; keep it so.
- **Anchors in `all.html`** carry the prefix in `ANCHOR`, which `site/search.js`
  repeats. Without it the TIMESTAMP chapter takes the id of the page's own
  `#timestamp` element.
- **`.nojekyll`** must stay in the output. Without it GitHub Pages converts
  every `pages/*.md` into an HTML file named like the chapter page.
- **The publish workflow** runs only for the paths listed in
  `.github/workflows/publish.yml`. A new top-level file that the build reads
  has to be added there.
- **`site/search.js`** wraps the title filter of `site/sidebar.js` instead of
  replacing it, so `head.html` loads `sidebar.js` first; both are `defer`. That filter walks a live list of every link in the sidebar,
  including the ones the search adds, so the search redraws its list after
  the filter has run.
- **`<a name="X"/>` in the guide** is not a closed tag in HTML: each of
  these 204 anchors holds everything up to the end of its block, often a whole
  chapter. Scripts that walk the page (`site/content.js`, the highlighting in
  `site/search.js`) must treat `<a>` without `href` as transparent and skip
  only `a[href]`.
- **Narrow screens.** `site/mobile.css` overrides `index.css` below 760
  pixels (`render_css` keeps that order when it inlines them), and `site/mobile.js` repeats that width. Check a visible change at both
  widths.
- **Grammar diagrams.** `build.py` loads `spec/tools/grammar_diagrams.py`
  and writes `grammar/*.html` from `spec/*.y` and `spec/keywords.tsv`. The
  generator follows the same rules as `build.py`: standard library only,
  Python 3.8. The publish workflow lists those spec files among its paths. A
  new grammar page needs an entry in the generator's `GRAMMARS`.
- **Text for other readers.** `plain_markdown` feeds the `.md` files and
  `plain_text` feeds the search index. New markup in the guide may need
  handling in both, as well as in `render_content`.

## Conventions

- Commit messages: Conventional Commits, `type(scope): imperative summary`,
  no sign-offs. Commit in logical parts; each commit should build.
- `master` is protected: changes arrive as pull requests and need one
  approval. Merging publishes the site within a minute or two.
- JavaScript: plain, no libraries. Variables that hold DOM elements end in
  `Element`.
- No new third-party scripts, fonts or CDNs on the pages.
- Update the README when a command, an output file or a behaviour described
  there changes.
