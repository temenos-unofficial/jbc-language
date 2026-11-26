// A "Copy" button on every code block and a link anchor on every section
// heading. Both are added here rather than by the build: ids written into the
// pages would change their compared text, and so their "Last update" dates.
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

  // The ids did not exist when the browser looked for the address's #part.
  if (location.hash.length > 1) {
    const targetElement = document.getElementById(decodeURIComponent(location.hash.slice(1)));
    if (targetElement && targetElement.closest("#content")) targetElement.scrollIntoView();
  }
})();
