import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["amount"];

  update(guestChange) {
    this.amountTarget.innerHTML =
      guestChange.detail * parseInt(this.data.get("barPrice"));
  }
}
