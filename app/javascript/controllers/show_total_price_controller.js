import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["totalPrice"]

  updatePrice() {
    const startDate = new Date(document.getElementById('check-in').value);
    const endDate = new Date(document.getElementById('check-out').value);
    const numberOfGuests = parseInt(document.getElementById('who').value) || 0;
    const pricePerNight = parseFloat(this.element.dataset.pricePerNight);

    const timeDifference = endDate - startDate;
    const numberOfNights = Math.ceil(timeDifference / (1000 * 3600 * 24));

    let totalPrice = 0;
    if (numberOfNights > 0 && numberOfGuests > 0) {
      totalPrice = numberOfNights * pricePerNight * numberOfGuests;
    }

    document.getElementById('total-price').innerText = totalPrice.toFixed(2);
  }
}
