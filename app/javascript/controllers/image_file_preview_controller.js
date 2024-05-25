import { Controller } from "@hotwired/stimulus";
import { installEventHandler } from "./mixins/event_handler";

// Connects to data-controller="image-file-preview"
export default class extends Controller {
  static targets = ["preview", "input"];

  initialize() {
    installEventHandler(this);
  }

  connect() {
    this.handleEvent("change", {
      on: this.inputTarget,
      with: this.previewImage,
    });
    this.handleEvent("error", {
      on: this.previewTarget,
      with: this.onPreviewError,
    });

    if (!this.previewTarget.src) {
      this.previewTarget.classList.add("hidden");
    }
  }

  onPreviewError = (event) => {
    event.preventDefault();
    this.previewTarget.classList.add("hidden");
  };

  previewImage = (event) => {
    const file = event.target.files[0];

    if (!file) return;

    // if the file is not an image, do nothing
    if (!file.type.startsWith("image/")) {
      alert("Please upload an image file.");
      this.inputTarget.value = "";
      return;
    }

    const reader = new FileReader();
    reader.onload = (event) => {
      this.previewTarget.src = event.target.result;
    };
    reader.readAsDataURL(file);

    this.previewTarget.classList.remove("hidden");
  };
}
