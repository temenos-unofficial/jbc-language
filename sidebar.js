// The sidebar: keeps its scroll position and the title filter between pages,
// and marks the current chapter. search.js wraps the filter, so this file is
// loaded before it.
var js = {
store: (function(){
if (sessionStorage) {
return function(){
if (arguments[0] !== undefined && arguments[1] !== undefined) {
if (arguments[1] == null) {
sessionStorage.removeItem(arguments[0]);return true;
} else {
sessionStorage[arguments[0]] = arguments[1];
return true;
}
} else if (arguments[0]) {
return sessionStorage[arguments[0]];
}
};
} else {
return function(){
if (arguments[0] !== undefined && arguments[1] !== undefined) {
if (arguments[1] == null) {
document.cookie = arguments[0] + "=" + encodeURIComponent(null) + new Date(0).toGMTString();
return true;
} else {
document.cookie = arguments[0] + "=" + encodeURIComponent(arguments[1]);
return true;
}
} else if (arguments[0]) {
var regexp  = new RegExp("(?:; )?" + arguments[0] + "=([^;]*);?");
if (regexp.test(document.cookie)) {
    return decodeURIComponent(regexp["$1"]);
}
return false;
}
}
}})(),
search: {
links: [],
headers: [],
init: function(){
var sidebar = document.getElementById("sidebar");
sidebar.scrollTop = js.store("scroll") ? js.store("scroll") : 0;
sidebar.addEventListener("scroll", function(){
js.store("scroll", this.scrollTop);
}, false)
sidebar.scrollTop = js.store("scroll") ? js.store("scroll") : 0;
this.links = sidebar.getElementsByTagName("a");
var h1 = document.getElementById("scrollable").getElementsByTagName("h1")[0].innerHTML;
this.headers = sidebar.getElementsByTagName("h2");
for (var a = js.search.links.length; a--;) {
if (js.search.links[a].innerHTML == h1) {
js.search.links[a].parentNode.className = "current";
}
}
var search_input = document.getElementById("search").getElementsByTagName("input")[0];
search_input.onkeyup = function(){
for (var a = js.search.links.length; a--;) {
if (this.value == "") {
js.store("search", null);
for (var h = js.search.headers.length; h--;) {
js.search.headers[h].style.display = "block";
}
} else {
js.store("search", this.value);
for (var h = js.search.headers.length; h--;) {
js.search.headers[h].style.display = "none";
}
}
if (js.search.links[a].innerHTML.toLowerCase().indexOf(this.value.toLowerCase()) != -1 || this.value == "") {
js.search.links[a].parentNode.style.display = "list-item";
} else {
js.search.links[a].parentNode.style.display = "none";
}
}
};
if (js.store("search")) {
search_input.value = js.store("search");
search_input.onkeyup.apply(search_input);
}
}
}
};
js.search.init();
