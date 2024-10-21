import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["star", "ratingInput", "submitButton", "contentInput"];

  connect() {
    this.updateStars();
    this.disableSubmitButton();
    this.contentInputTarget.addEventListener("input", this.validateForm.bind(this)); // Check when content is typed
  }

  updateStars() {
    const rating = parseInt(this.ratingInputTarget.value, 10);
    this.starTargets.forEach((star, index) => {
      if (index < rating) {
        star.classList.add('fas');  // full star, border black and filled black
        star.classList.remove('far'); // remove empty star
      } else {
        star.classList.add('far');   // empty star with black borderr
        star.classList.remove('fas'); // remove full star
      }
    });
  }

  setRating(event) {
    const newRating = this.starTargets.indexOf(event.currentTarget) + 1;
    this.ratingInputTarget.value = newRating;
    this.updateStars();
    this.validateForm(); // Check form validation when a star is clicked
  }

  disableSubmitButton() {
    this.submitButtonTarget.disabled = true;
  }

  enableSubmitButton() {
    this.submitButtonTarget.disabled = false;
  }

  validateForm() {
    const ratingSelected = parseInt(this.ratingInputTarget.value, 10) > 0;
    const contentValid = this.contentInputTarget.value.trim().length >= 10;

    if (ratingSelected && contentValid) {
      this.enableSubmitButton(); // Enable submit if both conditions are true
    } else {
      this.disableSubmitButton(); // Disable submit if conditions are not met
    }
  }
}
