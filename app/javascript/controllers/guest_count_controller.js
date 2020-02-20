import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["number", "minus", "plus", "countField"];

  add() {
    const guests = parseInt(this.numberTarget.value);
    if (guests === parseInt(this.data.get("maxGuest"))) return null;

    this.numberTarget.value = guests + 1;
    this.update();
  }

  remove() {
    const guests = parseInt(this.numberTarget.value);
    if (guests === 1) return null;

    this.numberTarget.value = guests - 1;
    this.update();
  }

  validateField() {
    if (!/^\d+$/.test(this.numberTarget.value))
      this.numberTarget.value = this.numberTarget.value.replace(/\D/g, "");

    if (parseInt(this.numberTarget.value) < 1 || this.numberTarget.value === "")
      this.numberTarget.value = 1;

    if (parseInt(this.numberTarget.value) > parseInt(this.data.get("maxGuest")))
      this.numberTarget.value = this.data.get("maxGuest");

    this.update();
  }

  update() {
    this.enableButton(this.minusTarget);
    this.enableButton(this.plusTarget);

    this.countFieldTarget.value = this.numberTarget.value;

    const event = new CustomEvent("guest_number_change", {
      detail: parseInt(this.countFieldTarget.value)
    });
    window.dispatchEvent(event);

    if (this.countFieldTarget.value === "1")
      this.disableButton(this.minusTarget);

    if (this.countFieldTarget.value === this.data.get("maxGuest"))
      this.disableButton(this.plusTarget);
  }

  disableButton(button) {
    button.classList.add("disabled");
  }

  enableButton(button) {
    button.classList.remove("disabled");
  }
}
