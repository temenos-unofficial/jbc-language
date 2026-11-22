// On a narrow screen the sidebar is a panel under the search bar. It opens
// from the button this script adds, and while the search box is in use.
(function () {
  "use strict";

  const searchElement = document.getElementById("search");
  const sidebarElement = document.getElementById("sidebar");
  if (!searchElement || !sidebarElement) return;

  const inputElement = searchElement.querySelector("input");
  // The same width as in mobile.css.
  const narrow = window.matchMedia("(max-width: 760px)");

  const toggleElement = document.createElement("button");
  toggleElement.type = "button";
  toggleElement.id = "menu-toggle";
  toggleElement.title = "Chapters";
  toggleElement.setAttribute("aria-label", "Chapters");
  toggleElement.setAttribute("aria-expanded", "false");
  toggleElement.textContent = "☰";
  searchElement.insertBefore(toggleElement, searchElement.firstChild);

  function isOpen() {
    return document.body.classList.contains("menu-open");
  }

  function setOpen(open) {
    if (open === isOpen()) return;
    document.body.classList.toggle("menu-open", open);
    toggleElement.setAttribute("aria-expanded", String(open));
    if (open) {
      // The page keeps the sidebar position in "scroll"; a hidden sidebar
      // could not take it when the page loaded.
      try {
        sidebarElement.scrollTop = Number(sessionStorage.getItem("scroll")) || 0;
      } catch (error) {
        // Storage can be blocked.
      }
    }
  }

  toggleElement.addEventListener("click", () => setOpen(!isOpen()));
  inputElement.addEventListener("focus", () => {
    if (narrow.matches) setOpen(true);
  });
  inputElement.addEventListener("input", () => {
    if (narrow.matches) setOpen(true);
  });
  inputElement.addEventListener("keydown", (event) => {
    // Enter shows the search results in the page, behind the panel.
    if (event.key === "Enter" && narrow.matches) {
      setOpen(false);
      inputElement.blur();
    }
  });
  sidebarElement.addEventListener("click", (event) => {
    if (event.target.closest && event.target.closest("a")) setOpen(false);
  });
  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && event.target !== inputElement) setOpen(false);
  });
  narrow.addEventListener("change", () => setOpen(false));
})();
