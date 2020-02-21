// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["bar", "menu"];

  createBar() {
    if (window.scrollY > 300) {
      this.barTarget.classList.add("affix");
    } else {
      this.barTarget.classList.remove("affix");
    }
  }

  menuTrigger(event) {
    event.target.classList.toggle("active");
    const menu = this.menuTarget;

    menu.classList.toggle("show_list");

    const container = document.getElementById("home-container");
    if (container.style.display === "none") {
      container.style.display = "block";
    } else {
      container.style.display = "none";
    }
    menu.style.opacity = 0;
    menu.style.display = "block";
    let opacity = 0;
    let request;

    const animation = () => {
      menu.style.opacity = opacity += 0.04;
      if (opacity >= 1) {
        opacity = 1;
        cancelAnimationFrame(request);
      }
    };

    const requestedAnimationFrame = () => {
      request = requestAnimationFrame(requestedAnimationFrame);
      animation();
    };
    requestedAnimationFrame();
  }
}
