import { Controller } from "@hotwired/stimulus";

// connects to data-controller="search-sugestions"
export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.inputTarget.addEventListener('input', this.handleInput.bind(this));
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
        this.showSuggestions(data); // display suggestions
      })
      .catch(error => console.error('Error:', error));
    } else {
      this.clearSuggestions(); // clear suggestions if less than 3 characters
    }
  }

  showSuggestions(suggestions) {
    const suggestionsContainer = document.getElementById('suggestions-container');
    suggestionsContainer.innerHTML = ""; // clear container first

    suggestions.forEach((suggestion) => {
      const suggestionItem = document.createElement('div');
      suggestionItem.classList.add('suggestion-item');
      suggestionItem.innerHTML = `${suggestion.title} (${suggestion.location})`;

      // make sugestion clickable
      suggestionItem.addEventListener('click', () => {
        this.inputTarget.value = suggestion.title; // insert title into input field
        this.clearSuggestions(); // clear suggestions after selection
      });

      suggestionsContainer.appendChild(suggestionItem);
    });
  }

  clearSuggestions() {
    const suggestionsContainer = document.getElementById('suggestions-container');
    suggestionsContainer.innerHTML = ""; // clear suggestions
  }
}
