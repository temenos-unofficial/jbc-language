# Notes for coding agents

Read `README.md` first for what the repository holds and how the site is
built. This file covers the constraints that are easy to break.

## Layout and scope

- The guide is one file, `jBC_Programmers_Reference_Guide.markdown`. Do not
  change its text unless the task is about the text; most of it was written by
  another author. Text conventions are in README "Contributing".
- `build.py` is the whole generator. It uses only the Python standard library
  and must keep running on Python 3.8. Do not add dependencies, a package
  manager or a JavaScript build step.
- `site/` holds the files the generator reads. `_site/` is the build output and
  is not tracked.
- The `gh-pages` branch is build output, written by the publish workflow. Never
  commit to it by hand.
- `skills/jbc/SKILL.md` is a skill for Claude Code and Codex that reads the
  published site. It is not used by the build.

## The comparison with the earlier site

`just verify` rebuilds the guide and compares it byte for byte with the site
published before this generator existed. It must keep reporting `0 differ`.
It clones a repository from GitHub, so it needs network access.

- `site/template.html` and `site/index.css` are part of that comparison. Do
  not edit them, not even to reformat. Anything new goes in through the
  deployment extras: `site/head.html`, `site/footer.html`, or a separate file
  written in the `if extras:` part of `build()`.
- `build()` is called with `extras=False` by `verify`. Everything specific to
  this deployment must stay behind that flag.
- Several things in `build.py` look like bugs and are deliberate, because the
  original generator did them: `&gt` without a semicolon in code, emphasis left
  alone on some lines, every line of a list block becoming an item, the missing
  links of the last group on `index.html`, the fallback for a mistyped anchor.
  Leave them unless `just verify` proves a change harmless.

## "Last update" dates

A page keeps its date only while its rendered text is unchanged; the previous
build is the only record (README "Last update dates").

- A change to what `render_content` or `highlight` produce gives every affected
  page today's date on the next publish. Avoid it unless that is the intent,
  and say so in the pull request.
- The head, the footer and the sidebar are outside the compared text, so
  changing them does not touch the dates.
- Locally a fresh clone has no previous build. To see real dates, unpack
  `gh-pages` into `_site/` first, as README shows.

## Checking a change

There are no unit tests. A change to the build is checked with:

1. `just build` twice: the second run must report `0 files changed`.
2. `just verify`: `0 differ`.
3. `just dev 18765` and a look at the pages in a browser, for anything visible.
   Use a high port; 8000 is often taken.

## Things that are connected

- **Chapter file names.** `slugify` decides them. The same names are used by
  the chapter pages, the `.md` files, `llms.txt`, `search.json`, the anchors in
  `all.html` and the rule described in `skills/jbc/SKILL.md` and in the README.
  Change them together, and remember that published addresses are linked from
  elsewhere.
- **Absolute addresses.** The extras use `/search.js`, `/all.html` and
  `/llms.txt`. The site is served from the root of its domain; keep it so.
- **Anchors in `all.html`** carry the prefix in `ANCHOR`, which `site/search.js`
  repeats. Without it the TIMESTAMP chapter takes the id of the page's own
  `#timestamp` element.
- **`.nojekyll`** must stay in the output. Without it GitHub Pages converts
  every `pages/*.md` into an HTML file named like the chapter page.
- **The publish workflow** runs only for the paths listed in
  `.github/workflows/publish.yml`. A new top-level file that the build reads
  has to be added there.
- **`site/search.js`** wraps the title filter of `template.html` instead of
  replacing it. That filter walks a live list of every link in the sidebar,
  including the ones the search adds, so the search redraws its list after
  the filter has run.
- **Narrow screens.** `site/mobile.css` overrides `index.css` below 760
  pixels, and `site/mobile.js` repeats that width. `#links` and `#contact` in
  `site/footer.html` carry inline styles, so the overrides for them need
  `!important`. Check a visible change at both widths.
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
