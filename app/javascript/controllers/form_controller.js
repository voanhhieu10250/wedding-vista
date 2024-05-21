import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  reset () {
    // console.log('resetting form');
    this.element.reset()
  }
}
