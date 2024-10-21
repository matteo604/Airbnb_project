import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["star", "ratingInput", "submitButton"]; // added submitButton target

  connect() {
    // Update stars display based on input value when the controller connects
    this.updateStars();
    this.disableSubmitButton(); // Disable submit button initially
  }

  // Updates the star display based on the hidden input field's value
  updateStars() {
    const rating = parseInt(this.ratingInputTarget.value, 10);
    this.starTargets.forEach((star, index) => {
      star.style.color = index < rating ? 'gold' : 'grey'; // Gold for selected stars, grey for non-selected
    });
  }

  // Called when a star is clicked
  setRating(event) {
    const newRating = this.starTargets.indexOf(event.currentTarget) + 1;
    this.ratingInputTarget.value = newRating; // Updates the hidden input field's value
    this.updateStars(); // Refreshes the stars display
    this.enableSubmitButton(); // Enable the submit button when a star is clicked
  }

  // Disable the submit button if no rating is selected
  disableSubmitButton() {
    this.submitButtonTarget.disabled = true; // Initially disable submit button
  }

  // Enable the submit button when a star is clicked
  enableSubmitButton() {
    this.submitButtonTarget.disabled = false; // Enable submit button once rating is selected
  }
}
