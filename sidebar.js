// The sidebar keeps its scroll position and the title filter from page to
// page, and shows the current chapter, which the build marks. search.js wraps the filter, so
// this file is loaded before it and the filter stays the input's onkeyup.
(function () {
  "use strict";

  const sidebarElement = document.getElementById("sidebar");
  const inputElement = document.querySelector("#search input");
  if (!sidebarElement || !inputElement) return;

  function remember(key, value) {
    try {
      if (value === undefined) return sessionStorage.getItem(key);
      if (value === null) sessionStorage.removeItem(key);
      else sessionStorage.setItem(key, value);
    } catch (error) {
      // Storage can be blocked; the sidebar works without it.
    }
    return null;
  }

  sidebarElement.scrollTop = Number(remember("scroll")) || 0;
  sidebarElement.addEventListener(
    "scroll",
    () => remember("scroll", String(sidebarElement.scrollTop)),
    { passive: true }
  );

  // Live lists: they include the links search.js adds to the sidebar.
  const linkElements = sidebarElement.getElementsByTagName("a");
  const headingElements = sidebarElement.getElementsByTagName("h2");

  inputElement.onkeyup = function () {
    const query = this.value.toLowerCase();
    remember("search", query === "" ? null : this.value);
    for (const headingElement of headingElements) {
      headingElement.style.display = query === "" ? "" : "none";
    }
    for (const linkElement of linkElements) {
      const shown = query === "" || linkElement.textContent.toLowerCase().includes(query);
      linkElement.parentNode.style.display = shown ? "" : "none";
    }
  };

  const saved = remember("search");
  if (saved) {
    inputElement.value = saved;
    inputElement.onkeyup();
  }

  // The saved position may not show the current chapter, after a jump from
  // the search box or a link in the text: then it is centred in the sidebar.
  // Scrolling the sidebar itself, not scrollIntoView, leaves the page alone.
  const currentElement = sidebarElement.querySelector("li.current");
  if (currentElement && currentElement.offsetParent && sidebarElement.clientHeight) {
    const sidebarBox = sidebarElement.getBoundingClientRect();
    const currentBox = currentElement.getBoundingClientRect();
    if (currentBox.top < sidebarBox.top || currentBox.bottom > sidebarBox.bottom) {
      sidebarElement.scrollTop += currentBox.top - sidebarBox.top - (sidebarBox.height - currentBox.height) / 2;
    }
  }
})();
