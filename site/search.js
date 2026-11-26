// Full-text search over search.json, which build.py writes next to this file.
// The search box keeps filtering chapter titles as before; this adds the
// chapters that mention the words, highlighting and a results view on Enter.
(function () {
  "use strict";

  const inputElement = document.querySelector("#search input");
  const sidebarElement = document.getElementById("sidebar");
  const contentElement = document.getElementById("content");
  const titleFilter = inputElement && inputElement.onkeyup;
  if (!titleFilter || !sidebarElement || !contentElement) return;

  const SINGLE_PAGE = document.querySelector("#content h1.group") !== null;
  const MENTIONS_SHOWN = 30;
  const MARKS_LIMIT = 2000;
  const SNIPPET_RADIUS = 70;
  const SKIPPED = "#timestamp, #pager, #contact, #links, #search-results, .copy-button, .heading-anchor, script, style";

  let chapters = null;
  let loading = null;
  let found = [];
  let highlightTimer = 0;

  const clearElement = document.createElement("button");
  clearElement.type = "button";
  clearElement.id = "search-clear";
  clearElement.title = "Clear search";
  clearElement.setAttribute("aria-label", "Clear search");
  clearElement.textContent = "\u00d7";
  document.getElementById("search").appendChild(clearElement);

  const mentionsElement = document.createElement("div");
  mentionsElement.id = "search-mentions";
  sidebarElement.appendChild(mentionsElement);

  const resultsElement = document.createElement("div");
  resultsElement.id = "search-results";
  contentElement.insertBefore(resultsElement, contentElement.firstChild);

  function remember(key, value) {
    try {
      if (value === undefined) return sessionStorage.getItem(key);
      if (value === null) sessionStorage.removeItem(key);
      else sessionStorage.setItem(key, value);
    } catch (error) {
      // Storage can be blocked; search works without it.
    }
    return null;
  }

  function escapeHtml(text) {
    return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
  }

  // Words must all occur; "quoted words" must occur together.
  function parse(query) {
    const terms = [];
    const pattern = /"([^"]+)"|(\S+)/g;
    let match;
    while ((match = pattern.exec(query)) !== null) {
      const term = (match[1] || match[2]).replace(/"/g, "").replace(/\s+/g, " ").trim().toLowerCase();
      if (term && terms.indexOf(term) === -1) terms.push(term);
    }
    return terms.join("").length < 2 ? [] : terms;
  }

  function termsPattern(terms) {
    const parts = terms
      .slice()
      .sort((one, two) => two.length - one.length)
      .map((term) => term.replace(/[.*+?^${}()|[\]\\]/g, "\\$&").replace(/ /g, "\\s+"));
    return new RegExp("(" + parts.join("|") + ")", "gi");
  }

  function count(text, term) {
    let total = 0;
    for (let at = text.indexOf(term); at !== -1; at = text.indexOf(term, at + term.length)) total++;
    return total;
  }

  function load() {
    if (!loading) {
      loading = fetch("/search.json")
        .then((response) => {
          if (!response.ok) throw new Error("search.json: " + response.status);
          return response.json();
        })
        .then((data) => {
          chapters = data.chapters.map((entry) => ({
            group: data.groups[entry[0]],
            slug: entry[1],
            title: entry[2],
            text: entry[3],
            lowerTitle: entry[2].toLowerCase(),
            lowerText: entry[3].toLowerCase(),
          }));
        })
        .catch((error) => {
          loading = null;
          console.error(error);
        });
    }
    return loading;
  }

  function search(terms, query) {
    const wanted = query.trim().toLowerCase();
    const matches = [];
    for (const chapter of chapters) {
      let score = chapter.lowerTitle === wanted ? 1000 : 0;
      let hits = 0;
      let all = true;
      for (const term of terms) {
        const inTitle = chapter.lowerTitle.indexOf(term);
        const inText = count(chapter.lowerText, term);
        if (inTitle === -1 && inText === 0) {
          all = false;
          break;
        }
        if (inTitle !== -1) score += inTitle === 0 ? 300 : 200;
        hits += inText;
      }
      if (all) matches.push({ chapter: chapter, hits: hits, score: score + Math.min(hits, 100) });
    }
    return matches.sort((one, two) => two.score - one.score || one.chapter.title.localeCompare(two.chapter.title));
  }

  function address(chapter) {
    // "chapter-" is ANCHOR in build.py.
    return SINGLE_PAGE ? "#chapter-" + chapter.slug : "/pages/" + chapter.slug + ".html";
  }

  function renderMentions(query) {
    // Chapters whose title matches are already shown by the title filter.
    const typed = query.toLowerCase();
    const others = found.filter((match) => match.chapter.lowerTitle.indexOf(typed) === -1);
    if (!found.length) {
      mentionsElement.innerHTML = "<p>Nothing in the text of the guide matches.</p>";
      return;
    }
    const items = others
      .slice(0, MENTIONS_SHOWN)
      .map(
        (match) =>
          '<li><a class="search-link" href="' +
          escapeHtml(address(match.chapter)) +
          '">' +
          escapeHtml(match.chapter.title) +
          '</a> <span class="search-count">' +
          match.hits +
          "</span></li>"
      )
      .join("");
    const more = found.length === 1 ? "the chapter" : "all " + found.length + " chapters";
    mentionsElement.innerHTML =
      (items ? "<h2>Mentioned in</h2><ul>" + items + "</ul>" : "") + "<p>Press Enter to see " + more + " with context.</p>";
  }

  function snippets(chapter, terms) {
    const pattern = termsPattern(terms);
    const out = [];
    let from = 0;
    for (const term of terms) {
      const at = chapter.lowerText.indexOf(term, from);
      if (at === -1) continue;
      let start = Math.max(from, at - SNIPPET_RADIUS);
      let end = Math.min(chapter.text.length, at + term.length + SNIPPET_RADIUS);
      if (start > from) start = Math.min(chapter.text.indexOf(" ", start) + 1 || start, at);
      if (end < chapter.text.length) end = Math.max(chapter.text.lastIndexOf(" ", end), at + term.length);
      const marked = chapter.text
        .slice(start, end)
        .split(pattern)
        .map((part, index) => (index % 2 ? '<mark class="search-hit">' + escapeHtml(part) + "</mark>" : escapeHtml(part)))
        .join("");
      out.push((start > 0 ? "\u2026 " : "") + marked + (end < chapter.text.length ? " \u2026" : ""));
      from = end;
      if (out.length === 2) break;
    }
    return out;
  }

  function resultsOpen() {
    return contentElement.classList.contains("searching");
  }

  function closeResults() {
    contentElement.classList.remove("searching");
    resultsElement.innerHTML = "";
  }

  function renderResults(query, terms) {
    const total = found.length === 1 ? "1 chapter" : found.length + " chapters";
    const items = found
      .map((match) => {
        const text = snippets(match.chapter, terms)
          .map((snippet) => "<p>" + snippet + "</p>")
          .join("");
        return (
          '<div class="search-result"><a class="search-link" href="' +
          escapeHtml(address(match.chapter)) +
          '">' +
          escapeHtml(match.chapter.title) +
          '</a> <span class="search-group">' +
          escapeHtml(match.chapter.group) +
          "</span>" +
          text +
          "</div>"
        );
      })
      .join("");
    resultsElement.innerHTML =
      "<h1>Search: " +
      escapeHtml(query) +
      '</h1><p class="search-summary">' +
      total +
      ' \u00b7 <a id="search-back" href="#">Back to the page</a></p>' +
      items;
    contentElement.classList.add("searching");
    contentElement.parentNode.scrollTop = 0;
  }

  function unmark() {
    const marks = contentElement.querySelectorAll("mark.search-hit");
    for (const mark of marks) {
      if (resultsElement.contains(mark)) continue;
      const parent = mark.parentNode;
      parent.replaceChild(document.createTextNode(mark.textContent), mark);
      parent.normalize();
    }
  }

  function mark(terms) {
    unmark();
    if (!terms.length) return;
    const pattern = termsPattern(terms);
    // A pattern with the "g" flag keeps its position between test() calls.
    const anywhere = new RegExp(pattern.source, "i");
    const walker = document.createTreeWalker(contentElement, NodeFilter.SHOW_TEXT, {
      acceptNode: (node) =>
        node.parentNode.closest(SKIPPED) || !anywhere.test(node.nodeValue)
          ? NodeFilter.FILTER_REJECT
          : NodeFilter.FILTER_ACCEPT,
    });
    const nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);
    let marked = 0;
    for (const node of nodes) {
      if (marked >= MARKS_LIMIT) break;
      const fragment = document.createDocumentFragment();
      node.nodeValue.split(pattern).forEach((part, index) => {
        if (!part) return;
        if (index % 2) {
          const hitElement = document.createElement("mark");
          hitElement.className = "search-hit";
          hitElement.textContent = part;
          fragment.appendChild(hitElement);
          marked++;
        } else {
          fragment.appendChild(document.createTextNode(part));
        }
      });
      node.parentNode.replaceChild(fragment, node);
    }
  }

  function refresh(showResults) {
    const query = inputElement.value;
    const terms = parse(query);
    clearTimeout(highlightTimer);
    if (!terms.length) {
      found = [];
      mentionsElement.innerHTML = "";
      closeResults();
      unmark();
      return;
    }
    if (!chapters) {
      load().then(() => {
        if (chapters && inputElement.value === query) refresh(showResults);
      });
      return;
    }
    found = search(terms, query);
    renderMentions(query);
    if (showResults || resultsOpen()) renderResults(query, terms);
    highlightTimer = setTimeout(() => {
      mark(terms);
      if (remember("search-jump") && !resultsOpen()) {
        remember("search-jump", null);
        const firstElement = [].find.call(
          contentElement.querySelectorAll("mark.search-hit"),
          (hitElement) => !resultsElement.contains(hitElement)
        );
        if (firstElement && !SINGLE_PAGE) firstElement.scrollIntoView({ block: "center" });
      }
    }, 150);
  }

  function update() {
    // The original handler filters the sidebar by title and stores the query.
    titleFilter.call(inputElement);
    clearElement.hidden = inputElement.value === "";
    refresh(false);
  }

  inputElement.onkeyup = null;
  inputElement.addEventListener("input", update);
  inputElement.addEventListener("focus", load);
  inputElement.addEventListener("keydown", (event) => {
    if (event.key === "Enter" && parse(inputElement.value).length) {
      refresh(true);
    } else if (event.key === "Escape") {
      if (resultsOpen()) {
        closeResults();
      } else {
        inputElement.value = "";
        update();
      }
    }
  });
  clearElement.addEventListener("click", () => {
    inputElement.value = "";
    update();
    inputElement.focus();
  });
  document.addEventListener("click", (event) => {
    const linkElement = event.target.closest ? event.target.closest("a") : null;
    if (!linkElement) return;
    if (linkElement.id === "search-back") {
      event.preventDefault();
      closeResults();
    } else if (linkElement.classList.contains("search-link")) {
      remember("search-jump", "1");
      if (SINGLE_PAGE) closeResults();
    }
  });

  clearElement.hidden = inputElement.value === "";
  refresh(false);
})();
