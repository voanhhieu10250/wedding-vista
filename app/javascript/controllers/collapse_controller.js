import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="collapse"
export default class extends Controller {
  static targets = ["toggleBtn", "content", "openIcon", "closeIcon"];
  static values = { open: Boolean };

  connect() {
    if (this.hasOpenValue) {
      this.openValueChanged();
    }
  }

  toggle() {
    this.openValue = !this.openValue;
  }

  openValueChanged() {
    this.contentTarget.hidden = !this.openValue;
    this.toggleBtnTarget.setAttribute("aria-expanded", this.openValue);
    this.openValue
      ? this.openIconTarget.classList.add("hidden")
      : this.openIconTarget.classList.remove("hidden");
    this.openValue
      ? this.closeIconTarget.classList.remove("hidden")
      : this.closeIconTarget.classList.add("hidden");
  }
}
