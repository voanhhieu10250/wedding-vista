import { Controller } from "@hotwired/stimulus";
import { installEventHandler } from "./mixins/event_handler";

// Connects to data-controller="services-search"
export default class extends Controller {
  static targets = [
    "search",
    "location",
    "pricing",
    "pricingFrom",
    "pricingTo",
    "submit",
  ];
  static values = {
    search: String,
    location: String,
    pricing: { type: String, default: "" },
  };

  initialize() {
    installEventHandler(this);
  }

  connect() {
    this.pricingClicked = false;
    this.initializePricing();
    this.handleEvent("turbo:submit-start", {
      on: this.element,
      with: this.form,
    });

    this.searchTargets.forEach((target) => {
      this.handleEvent("change", {
        on: target,
        with: this.search,
      });
      this.handleEvent("input", {
        on: target,
        with: this.search,
      });
    });

    this.locationTargets.forEach((target) => {
      this.handleEvent("change", {
        on: target,
        with: this.location,
      });
      this.handleEvent("input", {
        on: target,
        with: this.location,
      });
    });

    this.pricingTargets.forEach((target) => {
      this.handleEvent("change", {
        on: target,
        with: this.pricing,
      });
    });
  }

  form = (event) => {
    const formData = new FormData(event.target);
    // remove empty values
    const data = Array.from(formData).filter(function ([k, v]) {
      return v;
    });

    let searchParams = new URLSearchParams(data).toString();
    let url = event.target.action;
    if (searchParams) url += "?" + searchParams;

    event.detail.formSubmission.fetchRequest.url = new URL(url);
  };

  search = (event) => {
    this.searchValue = event.target.value;
  };

  location = (event) => {
    this.locationValue = event.target.value;
  };

  pricing = (event) => {
    this.pricingClicked = true;
    this.pricingValue = event.target.value;
  };

  pricingValueChanged(value) {
    // turn pricing value to range
    let [from, to] = value.replace("[", "").replace("]", "").split(",");

    this.pricingFromTargets.forEach((target) => {
      if (target.value !== value) target.value = from;
    });
    this.pricingToTargets.forEach((target) => {
      if (target.value !== value) target.value = to;
    });

    if (this.pricingClicked) {
      this.submitTarget.click();
    }
  }

  searchValueChanged(value) {
    this.searchTargets.forEach((target) => {
      if (target.value !== value) target.value = value;
    });
  }

  locationValueChanged(value) {
    this.locationTargets.forEach((target) => {
      if (target.value !== value) target.value = value;
    });
  }

  initializePricing() {
    const { pricingFrom, pricingTo } = this.element.dataset;
    let from = parseInt(pricingFrom, 0);
    let to = parseInt(pricingTo, 0);

    // turn pricing value to range
    let value = `[${from || ""},${to || ""}]`;
    this.pricingValue = value;

    this.pricingTargets.forEach((target) => {
      if (target.value === value) target.checked = true;
    });
  }
}
