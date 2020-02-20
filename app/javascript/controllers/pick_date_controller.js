import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["date", "from", "to", "startsAt", "endsAt"];

  setTimeRange(event) {
    const date = this.dateTarget.value;
    const from = this.fromTarget.value;
    const to = this.toTarget.value;

    const dateFrom = new Date(date + "T" + from);
    let dateTo = new Date(date + "T" + to);

    if (dateTo <= dateFrom) dateTo.setDate(dateTo.getDate() + 1);

    this.startsAtTarget.value = dateFrom;
    this.endsAtTarget.value = dateTo;
  }
}
