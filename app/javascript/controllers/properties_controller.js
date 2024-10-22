import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["title", "description", "pricePerNight", "propertyType", "submitButton"];

  connect() {
    // disable the submit button initially
    this.disableSubmitButton();

    // add event listeners to all fieldss
    this.titleTarget.addEventListener("input", this.validateForm.bind(this));
    this.descriptionTarget.addEventListener("input", this.validateForm.bind(this));
    this.pricePerNightTarget.addEventListener("input", this.validateForm.bind(this));
    this.propertyTypeTarget.addEventListener("change", this.validateForm.bind(this)); // Listen for property type changes
  }

  validateForm() {
    // check if title has at least 10 characters
    const titleValid = this.titleTarget.value.trim().length >= 10;

    // ccheck if description has at least 10 characters
    const descriptionValid = this.descriptionTarget.value.trim().length >= 10;

    // check if pricePerNight is valid (greater than 0)
    const priceValid = parseFloat(this.pricePerNightTarget.value) > 0;

    // check if propertyType is selected
    const propertyTypeValid = this.propertyTypeTarget.value !== "";

    // enable the submit button if all conditions are true
    if (titleValid && descriptionValid && priceValid && propertyTypeValid) {
      this.enableSubmitButton();
    } else {
      this.disableSubmitButton();
    }
  }

  disableSubmitButton() {
    this.submitButtonTarget.disabled = true;
  }

  enableSubmitButton() {
    this.submitButtonTarget.disabled = false;
  }
}
