// A "Copy" button on every code block, a link anchor on every section heading
// and links from statement and function names to their chapters. They are
// added here rather than by the build: changes written into the pages would
// change their compared text, and so their "Last update" dates.
(function () {
  "use strict";

  const contentElement = document.getElementById("content");
  if (!contentElement) return;

  // The text of a code block as it should be copied or run. Each line of a
  // code block is its own block-level <span>; the guide indents code, so the
  // indent every line shares is dropped.
  function codeText(preElement) {
    const lineElements = preElement.querySelectorAll(":scope > span:not(.code-buttons)");
    const lines = lineElements.length
      ? [].map.call(lineElements, (lineElement) => lineElement.textContent)
      : [].filter
          .call(preElement.childNodes, (node) => node.nodeType === Node.TEXT_NODE)
          .map((node) => node.textContent)
          .join("")
          .split("\n");
    const indent = Math.min(...lines.filter((line) => line.trim()).map((line) => line.match(/^ */)[0].length));
    const text = lines.map((line) => line.slice(indent).replace(/\s+$/, "")).join("\n");
    return text.replace(/^\n+|\n+$/g, "") + "\n";
  }

  // "Run" opens the block in the playground, in a new tab. check_examples.py
  // lists in site/runnable.txt the blocks that jbcc builds and runs, by a
  // hash of their text, and the build puts this page's hashes in
  // <meta name="jbc-runnable">; a block whose text changed gets no button.
  const PLAYGROUND = location.hostname === "localhost" ? "http://127.0.0.1:18767/" : "https://online.jbc-lang.org/";
  const runnableElement = document.querySelector('meta[name="jbc-runnable"]');
  const runnable = new Set(runnableElement ? runnableElement.content.split(" ") : []);

  // 32-bit FNV-1a of the UTF-8 text, as in check_examples.py.
  function fnv1a(text) {
    let value = 0x811c9dc5;
    for (const byte of new TextEncoder().encode(text)) value = Math.imul(value ^ byte, 0x01000193) >>> 0;
    return value.toString(16).padStart(8, "0");
  }

  function playgroundAddress(source, chapter) {
    let binary = "";
    for (const byte of new TextEncoder().encode(source)) binary += String.fromCharCode(byte);
    const code = btoa(binary).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
    // The playground names the file after the chapter: "locate" opens as locate.b.
    const name = chapter.replace(/[^A-Za-z0-9_.-]/g, "_").replace(/^[.-]+/, "").slice(0, 64);
    // run=1 asks the playground to run the block at once.
    return PLAYGROUND + "#" + (name ? "name=" + name + "&" : "") + "code=" + code + "&run=1";
  }

  function codeButton(text, label) {
    const buttonElement = document.createElement("button");
    buttonElement.type = "button";
    buttonElement.className = "copy-button";
    buttonElement.textContent = text;
    buttonElement.setAttribute("aria-label", label);
    return buttonElement;
  }

  // On all.html each chapter starts with an <h1 id="chapter-...">.
  let codeChapter = location.pathname.replace(/^.*\/|\.html$/g, "");
  for (const preElement of contentElement.querySelectorAll("h1[id^='chapter-'], pre")) {
    if (preElement.tagName === "H1") {
      codeChapter = preElement.id.slice("chapter-".length);
      continue;
    }
    const barElement = document.createElement("span");
    barElement.className = "code-buttons";
    const text = codeText(preElement);
    if (runnable.size && text.trim() && runnable.has(fnv1a(text))) {
      const runElement = document.createElement("a");
      runElement.className = "copy-button run-button";
      runElement.textContent = "Run";
      runElement.target = "_blank";
      runElement.rel = "noopener";
      runElement.title = "Open in the jBC playground";
      runElement.href = playgroundAddress(text, codeChapter);
      barElement.appendChild(runElement);
    }
    if (navigator.clipboard) {
      const buttonElement = codeButton("Copy", "Copy the code");
      buttonElement.addEventListener("click", () => {
        navigator.clipboard.writeText(codeText(preElement)).then(
          () => (buttonElement.textContent = "Copied"),
          () => (buttonElement.textContent = "Failed")
        );
        setTimeout(() => (buttonElement.textContent = "Copy"), 1500);
      });
      barElement.appendChild(buttonElement);
    }
    if (barElement.firstChild) preElement.appendChild(barElement);
  }

  // Heading anchors. On all.html the ids carry the chapter's id, since the
  // same section names recur in every chapter.
  function slug(text) {
    return text.toLowerCase().replace(/[^a-z0-9@]+/g, "-").replace(/^-|-$/g, "") || "section";
  }

  const used = new Set();
  let chapter = "";
  for (const headingElement of contentElement.querySelectorAll("h1, h2, h3")) {
    if (headingElement.closest("#search-results")) continue;
    if (headingElement.tagName === "H1") {
      chapter = headingElement.id ? headingElement.id + "-" : "";
      continue;
    }
    if (!headingElement.id) {
      let id = chapter + slug(headingElement.textContent);
      for (let n = 2; used.has(id) || document.getElementById(id); n++) {
        id = chapter + slug(headingElement.textContent) + "-" + n;
      }
      headingElement.id = id;
    }
    used.add(headingElement.id);
    const anchorElement = document.createElement("a");
    anchorElement.className = "heading-anchor";
    anchorElement.href = "#" + headingElement.id;
    anchorElement.textContent = "#";
    anchorElement.setAttribute("aria-label", "Link to this section");
    headingElement.appendChild(anchorElement);
  }

  // Links from names to chapters. The names are the sidebar's titles that are
  // a name of the language: "LOCATE", "@AM", "CacheGet", and the names in
  // titles such as "IF (statement)" or "QUOTE / DQUOTE / SQUOTE". In code,
  // every highlighted name is linked; in the text, the first mention of a
  // name in each chapter, written in capitals as the guide writes keywords.
  const NAME = "[@A-Za-z][A-Za-z0-9.$_@]*";
  const TITLE_WORDS = /\s*(\((statement|STATEMENT)\)|\bstatement|\bCommands?)$/;
  // "IN" is also a word of LOCATE, FOR and others, not only the IN statement.
  const CODE_SKIPPED = new Set(["@", "IN"]);
  const PROSE_SKIPPED = new Set(["@", "IN", "LN", "NOT"]);
  const chapters = new Map();
  let self = "";
  for (const linkElement of document.querySelectorAll("#sidebar li > a")) {
    if (linkElement.closest("#search-mentions")) continue;
    const title = linkElement.textContent.trim();
    const href = linkElement.getAttribute("href");
    if (linkElement.parentNode.classList.contains("current")) self = href;
    let names = [];
    if (!/\s/.test(title)) {
      // One word: a name in capitals or in CamelCase, not "Logger" or "Comments".
      if (/^[@A-Za-z]/.test(title) && /[A-Z@]/.test(title.slice(1))) names = [title];
    } else {
      // Names joined by ",", "/" or "and", or named as a statement or command;
      // not "BREAK ON/OFF" or "EMBEDDED SQL COMPILER OPTION".
      const words = title
        .replace(TITLE_WORDS, "")
        .replace(/\s*\(([^)]*)\)/g, ", $1")
        .split(/\s*(?:,|\/|\band\b)\s*/)
        .filter(Boolean);
      if (words.every((word) => /^[@A-Z][A-Z0-9.$_@]*$/.test(word))) names = words;
    }
    for (const name of names) {
      // A chapter named after exactly this title wins over "CONVERT (STATEMENT)".
      if (!chapters.has(name) || title === name) chapters.set(name, href);
    }
  }

  function chapterLink(name, href) {
    const linkElement = document.createElement("a");
    linkElement.className = "name-link";
    linkElement.href = href;
    linkElement.textContent = name;
    return linkElement;
  }

  const proseNames = [...chapters.keys()]
    .filter((name) => !PROSE_SKIPPED.has(name) && /^[@A-Z][A-Z0-9.$_@]*$/.test(name))
    .sort((one, two) => two.length - one.length)
    .map((name) => name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"));
  // A name stands alone: not part of a longer name, though it may end a sentence.
  const prosePattern = proseNames.length
    ? new RegExp("(^|[^A-Za-z0-9.$_@])(" + proseNames.join("|") + ")(?![A-Za-z0-9$_@]|\\.[A-Za-z0-9])", "g")
    : null;
  const NAME_RE = new RegExp("^" + NAME + "$");
  // An <a name> without href is only a target and may hold whole chapters.
  const LINK_SKIPPED = "a[href], h1, h2, h3, h4, #pager, #timestamp, footer, #search-results, script, style, button";

  let current = self;
  let linked = new Set();
  const proseNodes = [];
  const walker = document.createTreeWalker(contentElement, NodeFilter.SHOW_ELEMENT | NodeFilter.SHOW_TEXT, {
    acceptNode: (node) => {
      if (node.nodeType === Node.TEXT_NODE) return NodeFilter.FILTER_ACCEPT;
      if (node.tagName === "H1") {
        // On all.html every chapter starts with an <h1 id="chapter-...">.
        if (node.id.indexOf("chapter-") === 0) {
          current = "#" + node.id;
          linked = new Set();
        }
        return NodeFilter.FILTER_REJECT;
      }
      if (node.tagName === "PRE") {
        for (const spanElement of node.querySelectorAll(".c-0fun, .c-1com, .c-3typ")) {
          const name = spanElement.textContent;
          const href = chapters.get(name);
          if (href && href !== current && NAME_RE.test(name) && !CODE_SKIPPED.has(name)) {
            spanElement.textContent = "";
            spanElement.appendChild(chapterLink(name, href));
          }
        }
        return NodeFilter.FILTER_REJECT;
      }
      return node.matches(LINK_SKIPPED) ? NodeFilter.FILTER_REJECT : NodeFilter.FILTER_SKIP;
    },
  });
  while (prosePattern && walker.nextNode()) {
    const node = walker.currentNode;
    prosePattern.lastIndex = 0;
    let match;
    let from = 0;
    let fragment = null;
    while ((match = prosePattern.exec(node.nodeValue)) !== null) {
      const name = match[2];
      const href = chapters.get(name);
      if (href === current || linked.has(name)) continue;
      linked.add(name);
      const at = match.index + match[1].length;
      fragment = fragment || document.createDocumentFragment();
      fragment.appendChild(document.createTextNode(node.nodeValue.slice(from, at)));
      fragment.appendChild(chapterLink(name, href));
      from = at + name.length;
    }
    if (fragment) {
      fragment.appendChild(document.createTextNode(node.nodeValue.slice(from)));
      proseNodes.push([node, fragment]);
    }
  }
  for (const [node, fragment] of proseNodes) node.parentNode.replaceChild(fragment, node);

  // On the 404 page the report links name the address that was not found.
  const reportElement = document.getElementById("report");
  const reportEmailElement = document.getElementById("report-email");
  if (reportElement && reportElement.href.indexOf("404.html") !== -1) {
    const form = new URL(reportElement.href);
    form.searchParams.set("title", "Broken link: " + decodeURIComponent(location.pathname));
    form.searchParams.set("page", location.href);
    reportElement.href = form.href;
  }
  if (reportEmailElement && reportEmailElement.href.indexOf("404.html") !== -1) {
    reportEmailElement.href = reportEmailElement.href.replace(
      /Page%3A%20[^&]*?404\.html/,
      "Page%3A%20" + encodeURIComponent(location.href)
    );
  }

  // The ids did not exist when the browser looked for the address's #part.
  if (location.hash.length > 1) {
    const targetElement = document.getElementById(decodeURIComponent(location.hash.slice(1)));
    if (targetElement && targetElement.closest("#content")) targetElement.scrollIntoView();
  }
})();
