import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="service-details"
export default class extends Controller {
  static targets = ["description", "faqs", "review", "overlay"];
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

  openAllReviews(e) {
    e.target.parentElement.classList.add("!hidden");

    this.reviewTargets.forEach((review) => {
      review.classList.remove("!hidden");
    });
  }

  openOverlay(e) {
    this.overlayTarget.classList.remove("hidden");
  }

  closeOverlay(e) {
    this.overlayTarget.classList.add("hidden");
  }
}
