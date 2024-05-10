import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="flash"
export default class extends Controller {
  static values = { timeout: { type: Number, default: 4000 } };

  connect() {
    console.log("flash connected");
    setTimeout(this.#removeFlash.bind(this), this.timeoutValue);
  }

  #removeFlash() {
    this.element.addEventListener(
      "animationend",
      function removeFlashElement() {
        this.remove();
      },
      { once: true }
    );

    this.element.classList.add("animation-fadeOutUp");
  }
}
