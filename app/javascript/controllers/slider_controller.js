import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slider", "output"]

  connect() {
    this.updateValue(); // set the initial value on page load
    this.sliderTarget.addEventListener('input', this.updateValue.bind(this)); // update value on input
  }

  updateValue() {
    const value = parseInt(this.sliderTarget.value, 10);
    if (value === 16) {
      this.outputTarget.textContent = "16+"; // display 16+
    } else {
      this.outputTarget.textContent = value; // display the current slider value
    }
  }
}
