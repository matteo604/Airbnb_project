import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    flatpickr(document.querySelector("#check-in"), {
      dateFormat: "d-m-Y",
      minDate: "today", // Disabled date before today
      onChange: (selectedDates) => {
        if (selectedDates.length > 0) {
          const startDate = selectedDates[0];
          const endDate = new Date(startDate);
          endDate.setDate(endDate.getDate()+1)
          const endDateInput = document.querySelector("#check-out");
          if (endDateInput) {
            flatpickr((endDateInput), {
              dateFormat: "d-m-Y",
              minDate: endDate
             });
          }
        }
      }
    });
  }
}
