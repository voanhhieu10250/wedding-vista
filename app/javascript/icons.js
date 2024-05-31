import { createIcons, Eye, Plus, Search } from "lucide";

// NOTE: <i> can not be used with turbo_stream file, so we need to use <svg> instead
createIcons({
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
