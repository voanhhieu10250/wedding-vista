import { Controller } from "@hotwired/stimulus";
import { installEventHandler } from "./mixins/event_handler";

// Connects to data-controller="card-link"
export default class extends Controller {
  initialize() {
    installEventHandler(this);
  }

  connect() {
    this.handleEvent("click", {
      on: this.element,
      with: (e)=> e.preventDefault(),
    });
    this.handleEvent("click", {
      on: this.element,
      with: this.visit,
      delegation: true,
    });
  }

  visit = (event, target) => {
    Turbo.visit(target.href);
  };
}
