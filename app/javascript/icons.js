import { createIcons, Eye, Plus, Search } from "lucide";

// NOTE: <i> can not be used with turbo_stream file, so we need to use <svg> instead
const loadIcons = ()=>createIcons({
  attrs: {
    height: 18,
    width: 18,
  },
  icons: {
    Search,
    Plus,
    Eye,
  },
});

loadIcons();

document.addEventListener("turbo:load", loadIcons);