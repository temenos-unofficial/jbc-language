// A "Copy" button on every code block, a link anchor on every section heading
// and links from statement and function names to their chapters. They are
// added here rather than by the build: changes written into the pages would
// change their compared text, and so their "Last update" dates.
(function () {
  "use strict";

  const contentElement = document.getElementById("content");
  if (!contentElement) return;

  // Copy buttons. Each line of a code block is its own block-level <span>.
  if (navigator.clipboard) {
    for (const preElement of contentElement.querySelectorAll("pre")) {
      const buttonElement = document.createElement("button");
      buttonElement.type = "button";
      buttonElement.className = "copy-button";
      buttonElement.textContent = "Copy";
      buttonElement.setAttribute("aria-label", "Copy the code");
      buttonElement.addEventListener("click", () => {
        const lineElements = preElement.querySelectorAll(":scope > span");
        const lines = lineElements.length
          ? [].map.call(lineElements, (lineElement) => lineElement.textContent)
          : [].filter
              .call(preElement.childNodes, (node) => node !== buttonElement)
              .map((node) => node.textContent)
              .join("")
              .split("\n");
        // The guide indents code; drop the indent every line shares.
        const indent = Math.min(
          ...lines.filter((line) => line.trim()).map((line) => line.match(/^ */)[0].length)
        );
        const text = lines.map((line) => line.slice(indent).replace(/\s+$/, "")).join("\n");
        navigator.clipboard.writeText(text.replace(/\n+$/, "") + "\n").then(
          () => (buttonElement.textContent = "Copied"),
          () => (buttonElement.textContent = "Failed")
        );
        setTimeout(() => (buttonElement.textContent = "Copy"), 1500);
      });
      preElement.appendChild(buttonElement);
    }
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

  // The 404 page's report link names the address that was not found.
  const reportElement = document.getElementById("report");
  if (reportElement && reportElement.href.indexOf("404.html") !== -1) {
    reportElement.href = reportElement.href.replace(
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
