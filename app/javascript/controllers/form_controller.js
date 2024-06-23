import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "submit"]

  connect() {
    this.toggleSubmitButton();
  }

  toggleSubmitButton() {
    const inputValue = this.inputTarget.value.trim();
    this.submitTarget.disabled = inputValue === "";
  }

  handleInput() {
    this.toggleSubmitButton();
  }
}
