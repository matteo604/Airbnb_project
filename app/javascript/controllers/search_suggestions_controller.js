import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.inputTarget.addEventListener('input', this.handleInput.bind(this));
    this.inputTarget.addEventListener('blur', this.handleBlur.bind(this));
    document.addEventListener('click', this.handleDocumentClick.bind(this));
  }

  disconnect() {
    this.inputTarget.removeEventListener('input', this.handleInput.bind(this));
    this.inputTarget.removeEventListener('blur', this.handleBlur.bind(this));
    document.removeEventListener('click', this.handleDocumentClick.bind(this));
  }

  handleInput(event) {
    const query = event.target.value;

    if (query.length > 2) {
      fetch(`/properties/suggestions?query=${query}`, {
        method: 'GET',
        headers: {
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
      .then(response => response.json())
      .then((data) => {
        this.showSuggestions(data);
      })
      .catch(error => console.error('Error:', error));
    } else {
      this.clearSuggestions();
    }
  }

  handleBlur(event) {
    // intentionally empty to avoid interference with suggestion handling
  }

  handleDocumentClick(event) {
    if (!this.element.contains(event.target) && !event.target.classList.contains('suggestion-item') && !event.target.closest('.suggestion-item')) {
      this.clearSuggestions();
    }
  }

  showSuggestions(suggestions) {
    const suggestionsContainer = document.getElementById('suggestions-container');
    suggestionsContainer.innerHTML = ""; // clear previous suggestions

    suggestions.forEach((suggestion) => {
      const suggestionItem = document.createElement('div');
      suggestionItem.classList.add('suggestion-item');

      // ddisplay the suggestion with title and location
      suggestionItem.innerHTML = `
        <span>${suggestion.highlighted_title || suggestion.title}
        (${suggestion.highlighted_location || suggestion.location})</span>
        <button class="close-suggestion" aria-label="Close">&times;</button>
      `;

      // click event to add both title and location to the input field
      suggestionItem.querySelector('span').addEventListener('click', () => {
        // insert both tilte and location into the input field
        this.inputTarget.value = `${suggestion.title}, ${suggestion.location}`;
        this.clearSuggestions(); // Clear suggestions after selecting one
      });

      // close button to remove the suggestion item
      suggestionItem.querySelector('.close-suggestion').addEventListener('click', (event) => {
        event.preventDefault();
        event.stopPropagation();
        suggestionItem.remove(); // Remove only this suggestion item
      });

      // append the suggestion item to the container
      suggestionsContainer.appendChild(suggestionItem);
    });
  }


  clearSuggestions() {
    const suggestionsContainer = document.getElementById('suggestions-container');
    suggestionsContainer.innerHTML = "";
  }
}
