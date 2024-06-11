import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["item", "search"];
  static values = { search: "" };

  connect() {}

  search(e) {
    this.searchValue = e.target.value.trim();
  }

  searchValueChanged(value) {
    this.itemTargets.forEach((item) => {
      if (!value) {
        item.classList.remove("hidden");
      } else {
        const itemValue = this.removeDiacritics(
          item.dataset.value.toLowerCase()
        );
        const searchValue = this.removeDiacritics(value.toLowerCase());
        const isMatch = itemValue.includes(searchValue);
        item.classList.toggle("hidden", !isMatch);
      }
    });
  }

  removeDiacritics(str) {
    return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
  }
}
