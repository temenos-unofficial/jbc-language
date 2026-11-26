# Site improvement plan

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

## 2. Search engines: each page

All of these live in the head, outside the compared text, so they do not
change the "Last update" dates.

- [ ] `<html lang="en">` in `site/template.html` (and `single.html`, the
      grammar pages).
- [ ] Replace `<meta http-equiv="Content-type" ...>` with
      `<meta charset="utf-8">` as the first element of `<head>`.
- [ ] Descriptive titles: `{{chapter}} – jBC Programmers Reference Guide`,
      and for statements and functions say what they are, for example
      `LOCATE statement – jBC reference`. Keep the `<h1>` as it is.
- [ ] `<meta name="description">` per page from the existing `summary()`
      (it already feeds `llms.txt`), trimmed to about 155 characters.
- [ ] `<link rel="canonical" href="https://jbc-lang.org/pages/<slug>.html">`
      on every page, to settle http/https, `www` and trailing-slash
      variants.
- [ ] `all.html` holds the whole guide and competes with the chapter pages
      for the same searches. Decide: either `<meta name="robots"
      content="noindex, follow">` on it, or keep it indexable and accept
      the overlap. Recommended: noindex.
- [ ] `pages/*.md` duplicate the chapters as plain text. GitHub Pages cannot
      send `X-Robots-Tag`, so check in Search Console whether Google indexes
      them; if it does, add `Disallow: /pages/*.md` for Googlebot only and
      keep them open to the AI crawlers that `llms.txt` serves.
- [ ] Open Graph and Twitter card tags (title, description, URL, and an
      image built from `images/jbc-logo.png`) so links pasted into Slack,
      Discord, LinkedIn and the like show a proper preview.
- [ ] JSON-LD in the head: `TechArticle` per chapter with headline,
      description and `dateModified` from the stamp, plus `BreadcrumbList`
      (Guide › group › chapter).
- [ ] Rename chapters with weak titles ("Note", "Note 2", "Other",
      "Other notes") to say what they cover. This changes addresses (see
      "Chapter file names" in `AGENTS.md`), so add redirect stubs at the old
      addresses (a tiny page with meta refresh and canonical to the new one).

## 3. Speed

GitHub Pages already serves gzip over HTTP/2 from a CDN, and the pages are
small. The remaining wins:

- [ ] Load the GA4 tag after the page instead of in the head (inject
      `gtag/js` on `load` or `requestIdleCallback`; the `dataLayer` stub
      can stay inline so nothing is lost). It is the only third-party
      request and the largest script on every page. Check in GA4 Realtime
      that page views still arrive.
- [ ] Inline `index.css`, `search.css` and `mobile.css` into each page (or
      merge them into one file). Three render-blocking requests become zero
      or one; together they are a few KB.
- [ ] Move the inline sidebar script from the end of `template.html` into
      a deferred file shared by all pages, so browsers cache it once.
- [ ] Replace the base64 PNGs in `pages/calldotnet.html` with
      `<img src="/images/...">` carrying `width`, `height`, `loading="lazy"`
      and `decoding="async"`, and copy `images/` into the output. Convert
      them to WebP or optimise the PNGs. (This changes the page text and its
      date.)
- [ ] `search.json` (137 KB gzipped) already loads only when the search is
      used. Consider splitting it into a small title index and the full
      text index, so the first results appear sooner on slow connections.
- [ ] Add `<link rel="prefetch">` for the next chapter, or prefetch a link
      on hover or touch, so moving through the guide feels instant.
- [ ] Look at the 24 KB sidebar repeated on every page: either keep it (it
      gzips to little and helps crawlers) or load it once from a cached
      file. Recommended: keep it in the HTML; it is good for crawling and
      works without JavaScript.
- [ ] Optional, a bigger step: put Cloudflare (free plan) in front of
      GitHub Pages for long cache lifetimes on CSS, JS and images, Brotli,
      real 301 redirects and an `X-Robots-Tag` for the `.md` files. Needs a
      DNS change; decide before doing it.

## 4. Modern browser behaviour

- [ ] Real semantic layout: `<header>` for the search bar, `<nav
      aria-label="Chapters">` for the sidebar, `<main>` for the chapter,
      `<footer>` for the contact line. A "Skip to content" link first.
- [ ] Mark the current chapter with `aria-current="page"` in the built HTML
      (`build.py` knows it) instead of finding it with JavaScript.
- [ ] Give the search box a `<label>` (visually hidden), `type="search"`
      and `aria-controls` for the results.
- [ ] Add "Previous" and "Next" links at the bottom of every chapter, also
      as `<link rel="prev">`/`<link rel="next">` in the head.
- [ ] Dark mode: CSS custom properties for the colours in `index.css` and
      the syntax highlighting, switched by `prefers-color-scheme`, plus
      `<meta name="color-scheme" content="light dark">`.
- [ ] `<meta name="theme-color">` and a `site.webmanifest` with the existing
      icons, so the site looks right when added to a home screen.
- [ ] A "copy" button on code blocks (plain JavaScript in an existing
      script file).
- [ ] Anchor links on `<h2>`/`<h3>` headings inside chapters, so readers can
      share links to a section.
- [ ] Move the inline `style=` attributes in `site/footer.html` into CSS
      and drop the `!important` overrides in `mobile.css` that they force.
- [ ] Replace the cookie fallback in the template's `js.store` with a
      plain `try`/`catch` around `sessionStorage`; every browser in use has
      it.
- [ ] Print stylesheet: hide the sidebar and search when printing a
      chapter or `all.html`.

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
