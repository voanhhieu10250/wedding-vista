import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";
import { installEventHandler } from "./mixins/event_handler";

// Connects to data-controller="drop-zone"
export default class extends Controller {
  static targets = ["input", "dropZone", "results", "template"];
  static values = {
    activeClass: String,
    progress: String,
    wrapperSelector: { type: String, default: ".drop-zone-item-wrapper" },
  };

  initialize() {
    installEventHandler(this);
  }

  connect() {
    if (!this.hasInputTarget) {
      console.error(
        "No input target found. Please add a data-drop-zone-target='input' to the file input field."
      );
      return;
    }

    this.handleEvent("drop", {
      on: this.hasDropZoneTarget ? this.dropZoneTarget : this.element,
      with: this.handleOnDrop,
    });
    this.handleEvent("dragover", {
      on: this.hasDropZoneTarget ? this.dropZoneTarget : this.element,
      with: this.handleOnDragOver,
    });
    this.handleEvent("dragleave", {
      on: this.hasDropZoneTarget ? this.dropZoneTarget : this.element,
      with: this.handleOnDragLeave,
    });
    this.handleEvent("change", {
      on: this.inputTarget,
      with: this.handleOnChange,
    });
  }

  handleOnDrop = (event) => {
    event.preventDefault();
    this.#removeDropZoneActiveClass();

    if (event.dataTransfer.items) {
      // Use DataTransferItemList interface to access the file(s)
      Array.from(event.dataTransfer.items).forEach((item, i) => {
        // If dropped items aren't files, reject them
        if (item.kind === "file") {
          const file = item.getAsFile();
          // console.log("... file[" + i + "].name = " + file.name);
          this.#uploadFile(file);
        }
      });
    } else {
      const files = event.dataTransfer.files;
      // Use DataTransfer interface to access the file(s)
      Array.from(files).forEach((file, i) => {
        this.#uploadFile(file);
      });
    }
  };

  handleOnDragOver = (e) => {
    e.preventDefault();
    this.#addDropZoneActiveClass();
  };

  handleOnDragLeave = () => {
    this.#removeDropZoneActiveClass();
  };

  // Bind to normal file selection
  handleOnChange = (event) => {
    Array.from(this.inputTarget.files).forEach((file) =>
      this.#uploadFile(file)
    );
    // you might clear the selected files from the input
    this.inputTarget.value = null;
  };

  #uploadFile = (file) => {
    if (!this.#validateFile(file)) {
      return;
    }

    // your form needs the file_field direct_upload: true, which
    //  provides data-direct-upload-url
    const url = this.inputTarget.dataset.directUploadUrl;
    const upload = new DirectUpload(file, url, this);

    upload.create((error, blob) => {
      if (error) {
        // Handle the error
        console.error(error);
      } else {
        console.log("blob: ", blob);

        let content;

        if (this.hasTemplateTarget) {
          // Add an appropriately-named hidden input to the form with a
          //  value of blob.signed_id so that the blob ids will be
          //  transmitted in the normal upload flow
          content = this.templateTarget.innerHTML.replace(
            /TEMPLATE/g,
            blob.signed_id
          );

          // Find the img tag in the template and set its src to the
          // temporary URL of the uploaded file for preview
          // This regex pattern will effectively match both (src) and (src="anything")
          content = content.replace(
            /src(?:="[^"]*")?/g,
            'src="' + URL.createObjectURL(file) + '"'
          );

          content = content.replace(
            /data-new-item="false"/g,
            "data-new-item='true'"
          );
        } else {
          content = `<input type="hidden" name="${this.inputTarget.name}" value="${blob.signed_id}" />`;
        }

        if (this.hasResultsTarget) {
          // prepend the content to a results div
          this.resultsTarget.insertAdjacentHTML("afterbegin", content);
        } else {
          // append the content field to the closest form
          this.inputTarget
            .closest("form")
            .insertAdjacentHTML("beforeend", content);
        }
      }
    });
  };

  #addDropZoneActiveClass = () => {
    let activeClass = this.hasActiveClassValue
      ? this.activeClassValue
      : "drop-zone-active";

    if (this.hasDropZoneTarget) {
      this.dropZoneTarget.classList.add(activeClass);
    } else {
      this.element.classList.add(activeClass);
    }
  };

  #removeDropZoneActiveClass = () => {
    let activeClass = this.hasActiveClassValue
      ? this.activeClassValue
      : "drop-zone-active";

    if (this.hasDropZoneTarget) {
      this.dropZoneTarget.classList.remove(activeClass);
    } else {
      this.element.classList.remove(activeClass);
    }
  };

  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress", (event) =>
      this.progressUpdate(event)
    );
  }

  progressUpdate(event) {
    const progress = (event.loaded / event.total) * 100;
    console.log("progress: ", progress);

    if (this.hasProgressValue) {
      this.progressValue = progress;
    }

    // if you navigate away from the form, progress can still be displayed
    // with something like this:
    // document.querySelector("#global-progress").innerHTML = progress;
  }

  remove(e) {
    e.preventDefault();

    const wrapper = e.target.closest(this.wrapperSelectorValue);

    wrapper.remove();

    const event = new CustomEvent("drop-zone:remove", {
      bubbles: true,
    });
    this.element.dispatchEvent(event);
  }

  #validateFile = (file) => {
    // console.log("file: ", file);
    // Validate the file, only allow images
    if (!file.type.startsWith("image/")) {
      alert(`"${file.name}" is not an image file.
      Only images are allowed.`);
      return false;
    }

    if (file.size > 10000000) {
      alert("Upload file size must be less than 10MB");
      return false;
    }

    return true;
  };
}
