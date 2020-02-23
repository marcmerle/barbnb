import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["div", "form"];

  connect() {
    this.variable = this.data.get("variable");
    this.datatype = this.data.get("datatype");
  }

  toggle() {
    if (!this.data.get("toggled") == 1) {
      this.divTarget.innerHTML = this.form();

      this.data.set("toggled", 1);
    }
  }

  close(event) {
    if (
      this.element.contains(event.target) === false &&
      this.data.get("toggled") == 1
    ) {
      this.submit();
    }
  }

  submit() {
    this.formTarget.submit();
  }

  form() {
    let type = `input type="${this.datatype}"`;
    let end = "";

    if (this.datatype === "textarea") {
      type = 'textarea rows ="5" cols="88"';
      end = `${this.input_value}</textarea>`;
    }

    return `
      <form action="${this.post_url}" accept-charset="UTF-8" data-remote="true" data-target="inline-edit.form" method="post" style="display: inline-block;">
        <input name="utf8" type="hidden" value="✓">
        <input type="hidden" name="_method" value="patch">
        <input type="hidden" name="authenticity_token" value="${this.authenticity_token}">
        <${type} value="${this.input_value}" name="bar[${this.variable}]" id="bar_${this.variable}" data-target="inline-edit.input" data-action="onblur->inline-edit#submit">
        ${end}
      </form>
    `;
  }

  get input_value() {
    return this.divTarget.textContent;
  }

  get post_url() {
    return window.location.pathname;
  }

  get authenticity_token() {
    return document
      .querySelector("meta[name='csrf-token']")
      .getAttribute("content");
  }
}
