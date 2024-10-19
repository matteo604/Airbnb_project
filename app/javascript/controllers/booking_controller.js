import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkIn", "checkOut", "totalPrice"]

  connect() {
    this.checkInTarget.addEventListener('change', this.updatePrice.bind(this));
    this.checkOutTarget.addEventListener('change', this.updatePrice.bind(this));
  }

  updatePrice() {
    const checkInDate = new Date(this.checkInTarget.value);
    const checkOutDate = new Date(this.checkOutTarget.value);

    if (checkInDate && checkOutDate && checkOutDate > checkInDate) {
      const dayDifference = Math.ceil((checkOutDate - checkInDate) / (1000 * 60 * 60 * 24));
      const pricePerNight = parseFloat(this.data.get("pricePerNight"));

      const totalPrice = dayDifference * pricePerNight;
      this.totalPriceTarget.innerHTML = `Total Price: ${totalPrice.toFixed(2)} $`;
    } else {
      this.totalPriceTarget.innerHTML = "Total Price: N/A";
    }
  }
}
