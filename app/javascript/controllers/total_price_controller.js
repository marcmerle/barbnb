import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["amount", "barPrice"];

  connect() {
    const countButtons = document.querySelectorAll("#guest-count .count-button");
    const guestNumber = document.querySelector("#guest-count input");
    this.amountTarget.innerHTML = parseInt(guestNumber.value) * parseInt(this.barPriceTarget.innerHTML)

    countButtons.forEach((constButton) => {
      constButton.addEventListener("click", () => {
        if (constButton.dataset.target === "guest-count.minus" && guestNumber.value > 1) {
          this.update(parseInt(guestNumber.value) - 1)
        } else if (constButton.dataset.target === "guest-count.plus") {
          this.update(parseInt(guestNumber.value) + 1)
        };
      })
    });

    guestNumber.addEventListener("input", () => {
      this.update(guestNumber.value)
    });
  }

  update(guestNumber) {
    this.amountTarget.innerHTML = parseInt(guestNumber) * parseInt(this.barPriceTarget.innerHTML)
  }
}
