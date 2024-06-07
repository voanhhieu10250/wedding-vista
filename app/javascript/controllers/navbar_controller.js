import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="navbar"
export default class extends Controller {
  static values = {
    mobileMenuOpen: Boolean,
  };
  static targets = ["mobileMenu", "closedIcon", "openedIcon"];

  connect() {
    this.overlayTarget = document.getElementById("header-overlay");
  }

  toggleMobileMenu() {
    this.mobileMenuOpenValue = !this.mobileMenuOpenValue;
  }

  mobileMenuOpenValueChanged() {
    if (this.mobileMenuOpenValue) {
      this.mobileMenuTarget.classList.remove("hidden");
      this.closedIconTarget.classList.add("hidden");
      this.openedIconTarget.classList.remove("hidden");
    } else {
      this.mobileMenuTarget.classList.add("hidden");
      this.closedIconTarget.classList.remove("hidden");
      this.openedIconTarget.classList.add("hidden");
    }
  }

  toggleOverlay(event) {
    this.overlayTarget.classList.toggle("opacity-0");
    this.overlayTarget.classList.toggle("hidden");
  }
}
