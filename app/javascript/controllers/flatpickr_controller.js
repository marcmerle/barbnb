import Flatpickr from "stimulus-flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js";

export default class extends Flatpickr {
  static targets = ["date", "from", "to"];

  initialize() {
    this.config = {
      locale: French,
      inline: true,
      minuteIncrement: 15,
      time_24hr: true
    };
  }

  connect() {
    super.connect();

    if (this.inputTarget.id === "time-from") {
      this.calendarContainerTarget.classList.add("first-timer-child");
    } else if (this.inputTarget.id === "time-to") {
      this.calendarContainerTarget.classList.add("second-timer-child");
    }
    console.log(this);
  }

  change(_0, _1, instance) {
    const event = new Event("change");
    instance.element.dispatchEvent(event);
  }
}
