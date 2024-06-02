import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="side-modal"
export default class extends Controller {
  static targets = ["modal"];

  connect() {}

  open(e) {
    this.modalTarget.classList.remove("hidden");
  }

  close(e) {
    this.modalTarget.classList.add("hidden");
  }

  clickOutside(e) {
    if (e.target.ariaModal) this.close();
  }
}
