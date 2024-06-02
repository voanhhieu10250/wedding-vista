import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="service-details"
export default class extends Controller {
  static targets = ["description", "faqs"];
  connect() {}

  toggleDescriptionReadMore(e) {
    this.descriptionTarget.classList.toggle("truncate-overflow");

    if (this.descriptionTarget.classList.contains("truncate-overflow")) {
      e.target.innerText = "Đọc thêm";
    } else {
      e.target.innerText = "Ẩn bớt";
    }
  }

  openAllFAQs() {
    this.faqsTarget.classList.add("all");
  }
}
