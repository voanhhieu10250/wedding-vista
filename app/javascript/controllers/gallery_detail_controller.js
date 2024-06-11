import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="gallery-detail"
export default class extends Controller {
  static targets = ["modal"];

  connect() {}

  outside(e) {
    if (e.target.ariaModal) this.close();
  }

  open(e) {
    console.log(e.currentTarget.dataset.itemId);
    const itemId = e.currentTarget.dataset.itemId;

    this.modalTargets.forEach((modal) => {
      console.log(modal.dataset.itemId);
      if (modal.dataset.itemId == itemId) {
        modal.classList.remove("hidden");
      }
    });
  }

  close(e) {
    this.modalTargets.forEach((modal) => {
      modal.classList.add("hidden");
    });
  }
}
