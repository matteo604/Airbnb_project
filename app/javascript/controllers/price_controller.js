// app/javascript/controllers/price_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["startDate", "endDate", "guests", "totalPrice"];
  static values = {night: Number}

  connect() {
    this.calculatePrice();
  }

  updatePrice() {
    this.calculatePrice();
  }

  calculatePrice() {
    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);
    const numberOfGuests = this.guestsTarget.value;
    const totalDays = (endDate - startDate)/(1000 * 60 * 60 * 24)
    const price_per_night = this.nightValue;
    const myDiv = document.getElementById("total-price")
    if (!isNaN(startDate) && !isNaN(endDate) && !isNaN(numberOfGuests)) {
      const totalPrice = price_per_night * numberOfGuests * totalDays;
      console.log(endDate)
      myDiv.textContent = totalPrice + "$"
    } else {
      myDiv.textContent = "--"
    }
 }
}
