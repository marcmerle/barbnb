import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["star", "form"];

  setRating(event) {
    const star = event.target;
    this.formTarget.value = star.dataset.id;
  }

  chooseRating(event) {
    const id = event.target.dataset.id;
    this.colorStars(id);
  }

  showRating() {
    const rating = this.formTarget.value || 0;
    this.colorStars(rating);
  }

  colorStars(limit) {
    this.starTargets.forEach(star => {
      if (star.dataset.id <= limit) {
        star.classList.remove("far");
        star.classList.add("fas");
      } else {
        star.classList.remove("fas");
        star.classList.add("far");
      }
    });
  }
}
