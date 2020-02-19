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
}
