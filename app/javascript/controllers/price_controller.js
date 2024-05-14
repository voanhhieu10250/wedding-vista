import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="price"
export default class extends Controller {
  formatPriceWithCommas() {
    const price = this.element.value.replace(/\D/g, "");
    this.element.value = price.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
}
