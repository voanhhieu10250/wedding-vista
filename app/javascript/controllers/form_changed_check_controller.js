import { Controller } from "@hotwired/stimulus";
import { installEventHandler } from "./mixins/event_handler";

// Connects to data-controller="form-changed-check"
export default class extends Controller {
  static values = { dirty: Boolean };

  initialize() {
    installEventHandler(this);
  }

  connect() {
    this.dirtyValue = false;
    this.initialFormState = this.serializeForm();

    this.handleEvent("turbo:before-visit", {
      with: this.confirmSubmit,
    });
    this.handleEvent("turbo:submit-start", {
      with: this.resetDirtyState,
    });
  }

  confirmSubmit = (event) => {
    if (this.dirtyValue) {
      if (
        !confirm("You have unsaved changes. Are you sure you want to continue?")
      ) {
        event.preventDefault();
      }
    }
  };

  checkDirty = (event) => {
    const currentFormState = this.serializeForm();
    this.dirtyValue = !this.compareFormData(
      this.initialFormState,
      currentFormState
    );
    this.updateFormStateIndicator();
  };

  serializeForm() {
    const formData = new FormData(this.element);
    const serialized = {};

    formData.forEach((value, key) => {
      if (value instanceof File) {
        serialized[key] = {
          name: value.name,
          size: value.size,
          type: value.type,
        };
      } else {
        serialized[key] = value;
      }
    });

    return serialized;
  }

  compareFormData(initial, current) {
    const initialKeys = Object.keys(initial);
    const currentKeys = Object.keys(current);

    if (initialKeys.length !== currentKeys.length) return false;

    for (const key of initialKeys) {
      const initialValue = initial[key];
      const currentValue = current[key];

      if (initialValue instanceof Object && currentValue instanceof Object) {
        if (
          initialValue.name !== currentValue.name ||
          initialValue.size !== currentValue.size ||
          initialValue.type !== currentValue.type
        ) {
          return false;
        }
      } else {
        if (initialValue !== currentValue) return false;
      }
    }

    return true;
  }

  updateFormStateIndicator() {
    if (this.dirtyValue) {
      this.element.classList.add("is-dirty");
    } else {
      this.element.classList.remove("is-dirty");
    }
  }

  resetForm(event) {
    event.preventDefault();
    this.initialFormState = this.serializeForm();
    this.dirtyValue = false;
    this.updateFormStateIndicator();
    this.element.reset();
  }

  resetDirtyState = () => {
    console.log("resetDirtyState");
    this.dirtyValue = false;
    this.updateFormStateIndicator();
  };
}
