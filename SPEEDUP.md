# Site improvement plan

`[x]` done, `[ ]` open, `[-]` decided against.

A plan for better search ranking, speed and modern browser behaviour of
<https://jbc-lang.org>. Every item has to fit the rules in `AGENTS.md`:
`build.py` stays standard-library Python 3.8, no JavaScript build step, no new
third-party scripts, fonts or CDNs, and changes to the rendered page text
reset the "Last update" dates (head, footer and sidebar do not).

## Where the site stands (measured 2026-11-26)

- 414 static chapter pages plus `pages/*.md`, `all.html` (992 KB, 220 KB
  gzipped), `search.json` (468 KB, 137 KB gzipped), `llms.txt`,
  `llms-full.txt` and `grammar/*.html`. Served by GitHub Pages with gzip.
- Chapter pages are small (around 28 KB, 6 KB gzipped). About 24 KB of that
  is the sidebar, repeated on every page.
- `/robots.txt` and `/sitemap.xml` return 404. The 404 page is GitHub's
  default.
- `/` reaches the first chapter through a JavaScript redirect
  (`window.location = "pages/preface.html"`).
- No `lang` on `<html>`, no meta description, no canonical link, no Open
  Graph tags. Titles are the bare chapter name ("Comments", "Note 2").
- `cache-control: max-age=600` on everything: GitHub Pages fixes it and the
  site cannot set its own headers.
- The GA4 Google tag (`gtag/js`) loads in the `<head>` of every page; it
  replaced the GTM container in `3ce4458`.
- `pages/calldotnet.html` has two PNGs embedded as base64 (76 KB page), and
  the same files exist in `images/`.

## 1. Search engines: the basics

- [x] Add `site/robots.txt` that allows everything and names the sitemap
      (`Sitemap: https://jbc-lang.org/sitemap.xml`).
- [x] Generate `sitemap.xml` in `build.py`: the home page, every chapter
      page and the grammar pages, with `<lastmod>` taken from the same stamp
      as "Last update". Leave out the `.md` files, the group pages (only a
      heading) and `all.html` (see section 2).
- [x] Add `/robots.txt`, `/sitemap.xml` and anything new in `site/` to the
      publish workflow paths if they need it (`site/**` already matches).
- [x] Make `/` a real page instead of a JavaScript redirect: a home page
      with the guide title, a short introduction, the chapter groups and
      links to the grammar, playground and jbcc. It is the page with the most
      links pointing to it, so it should carry content and not bounce.
- [x] ~~Until the home page exists, add a meta refresh~~: not needed, the
      home page came first.
- [x] Add a custom `404.html` (GitHub Pages serves it automatically) with
      the sidebar and the search box, so a broken link still leads into the
      guide. `just dev` serves it for missing addresses too.
- [ ] Register the site in Google Search Console and Bing Webmaster Tools,
      submit the sitemap, and check the coverage report after a week.
  - [x] Google Search Console: URL-prefix property `https://jbc-lang.org/`
        added 2026-11-26, verified through the GA4 tag (keep the tag, or add
        a second verification method under Settings › Ownership
        verification).
  - [x] Submit `sitemap.xml` in Search Console: submitted 2026-11-26 after
        #16 was published. "Couldn't fetch" at first, "Success" with 404
        discovered pages the same day.
  - [ ] Bing Webmaster Tools: import the site from Search Console.
  - [ ] A week later: read the Page indexing report.

## 2. Search engines: each page

All of these live in the head, outside the compared text, so they do not
change the "Last update" dates.

- [x] `<html lang="en">` in `site/template.html` (the grammar pages
      already had it; `single.html` is only a head fragment).
- [x] Replace `<meta http-equiv="Content-type" ...>` with
      `<meta charset="utf-8">` as the first element of `<head>`.
- [x] Descriptive titles: `{{chapter}} – jBC Programmers Reference Guide`.
      Keep the `<h1>` as it is.
- [ ] For statements and functions, say what they are in the title, for
      example `LOCATE statement – jBC reference`. The guide does not mark
      which chapters are statements and which are functions, so this needs
      a list or a rule first.
- [x] `<meta name="description">` per page from the existing `summary()`
      (it already feeds `llms.txt`), trimmed to about 155 characters. The
      five chapters without a first sentence get a stock one.
- [x] `<link rel="canonical" href="https://jbc-lang.org/pages/<slug>.html">`
      on every page, to settle http/https, `www` and trailing-slash
      variants.
- [x] `all.html` holds the whole guide and competes with the chapter pages
      for the same searches. It already had `<meta name="robots"
      content="noindex">` from `site/single.html`. The 13 group pages,
      which hold only a heading, now get `noindex` too.
- [ ] `pages/*.md` duplicate the chapters as plain text. GitHub Pages cannot
      send `X-Robots-Tag`, so check in Search Console whether Google indexes
      them; if it does, add `Disallow: /pages/*.md` for Googlebot only and
      keep them open to the AI crawlers that `llms.txt` serves.
- [x] Open Graph and Twitter card tags (title, description, URL, and an
      image built from `images/jbc-logo.png`) so links pasted into Slack,
      Discord, LinkedIn and the like show a proper preview.
- [x] JSON-LD in the head: `TechArticle` per chapter with headline,
      description and `dateModified` from the stamp, plus `BreadcrumbList`
      (Guide › chapter; the group pages are empty, so they are not a
      level).
- [ ] Rename chapters with weak titles ("Note", "Note 2", "Other",
      "Other notes") to say what they cover. This changes addresses (see
      "Chapter file names" in `AGENTS.md`), so add redirect stubs at the old
      addresses (a tiny page with meta refresh and canonical to the new one).

## 3. Speed

GitHub Pages already serves gzip over HTTP/2 from a CDN, and the pages are
small. The remaining wins:

- [x] Load the GA4 tag after the page instead of in the head: `gtag/js` is
      injected on `load`, the `dataLayer` stub stays inline. Checked
      locally that `page_view` is still sent.
  - [x] Search Console's Analytics verification expects the script in the
        HTML head, so a `google-site-verification` meta tag is added.
  - [x] After publishing: Verify for the HTML tag method in Search
        Console (Settings › Ownership verification) succeeded on
        2026-11-26; both methods show as verified.
  - [ ] Check GA4 Realtime for page views from the live site.
- [x] Inline `index.css`, `search.css` and `mobile.css` into each page.
      Three render-blocking requests become none, for about 2 KB gzipped
      per page. The files are still published.
- [x] Move the inline sidebar script from the end of `template.html` into
      `sidebar.js`, deferred and loaded before `search.js`.
- [x] Replace the base64 PNGs in `pages/calldotnet.html` with
      `<img src="/images/...">` carrying `width`, `height`, `loading="lazy"`
      and `decoding="async"`. The build writes them out, so the guide's
      Markdown is unchanged. The page drops from 79 KB to 35 KB, and it and
      `all.html` take a new date.
- [-] Skipped: convert the two screenshots to WebP or optimise the PNGs
      (35 KB together; the build has no image tools, so by hand).
- [-] Skipped: `search.json` (137 KB gzipped) already loads only when the
      search is used. Splitting it into a small title index and the full
      text index would make the first results appear sooner on slow
      connections.
- [x] Prefetch a chapter on hover: a speculation rule (`eagerness:
      moderate`) for `/pages/*.html`. Chromium only; others ignore it. Not
      seen working in the test browser, which has prefetching switched off.
- [x] Keep the 24 KB sidebar in every page's HTML: it gzips to little,
      helps crawlers and works without JavaScript.
- [-] Skipped: put Cloudflare (free plan) in front of
      GitHub Pages for long cache lifetimes on CSS, JS and images, Brotli,
      real 301 redirects and an `X-Robots-Tag` for the `.md` files. Needs a
      DNS change; decide before doing it.

## 4. Modern browser behaviour

- [x] Semantic layout: `<nav aria-label="Chapters">` for the sidebar,
      `<main>` for the scrolling area, `role="search"` on the search bar,
      `<footer>` for the contact line, and a "Skip to content" link first.
      `<div id="content">` stays: the build compares the text after it.
- [x] Mark the current chapter with `class="current"` and
      `aria-current="page"` in the built HTML instead of finding it with
      JavaScript.
- [x] Give the search box a visually hidden `<label>`, `type="search"`
      and `aria-controls="sidebar"`.
- [x] "Previous" and "Next" links above "Last update" on every chapter,
      also as `<link rel="prev">`/`<link rel="next">`. `split_page` leaves
      them out of the compared text, so no dates change.
- [x] Dark mode: custom properties for the colours, switched by
      `prefers-color-scheme`, plus `<meta name="color-scheme">`. Code blocks
      were already dark and keep their highlighting colours.
- [x] `<meta name="theme-color">` for both schemes and a
      `site.webmanifest` with the existing icons.
- [x] A "Copy" button on code blocks, in a new `content.js`; it drops the
      indent the lines share.
- [x] Anchor links on `<h2>`/`<h3>` headings, added by `content.js` so the
      compared text stays the same (ids carry the chapter on `all.html`).
- [x] Move the inline `style=` attributes in `site/footer.html` into CSS
      and drop the `!important` overrides in `mobile.css`.
- [x] Replace the cookie fallback in `js.store` with `sessionStorage`
      behind `try`/`catch` (`sidebar.js` was rewritten).
- [x] Print stylesheet (`print.css`): only the chapter, black on white.

## 5. Checking

- [ ] For every change: `just build` twice (second run `0 files changed`),
      `just check`, and `just dev 18765` at wide and narrow widths, as
      `AGENTS.md` describes.
- [ ] Before and after numbers from Lighthouse (mobile) for `/`, a chapter
      page and `all.html`: Performance, Accessibility, Best Practices, SEO.
- [ ] Validate one page of each kind with the W3C validator and Google's
      Rich Results Test (for the JSON-LD).
- [ ] Check link previews with a pasted link in Slack or Discord.
- [ ] Update `README.md` for new output files (`robots.txt`,
      `sitemap.xml`, `404.html`, the home page) and anything else the
      README describes.

## Suggested order

1. Section 2 head changes and section 1 robots, sitemap and 404: cheap,
   no date changes, the biggest SEO gain.
2. The home page at `/`.
3. GA4 tag and CSS loading.
4. Semantic layout, prev/next, dark mode.
5. Chapter renames and the Cloudflare decision.
