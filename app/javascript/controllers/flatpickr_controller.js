import Flatpickr from "stimulus-flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js";

export default class extends Flatpickr {
  initialize() {
    this.config = {
      locale: French,
      inline: true,
      minuteIncrement: 15,
      time_24hr: true
    };
    console.log("init!");
  }

  // all flatpickr hooks are available as callbacks in your Stimulus controller
  change(selectedDates, dateStr, instance) {
    console.log("the callback returns the selected dates", selectedDates);
    console.log("but returns it also as a string", dateStr);
    console.log("and the flatpickr instance", instance);
  }
}
