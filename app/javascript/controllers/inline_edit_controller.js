import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "field", "form", "button", "submit" ]

  toggle() {
    this.fieldTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
    this.buttonTarget.classList.add("hidden")
    this.submitTarget.classList.remove("hidden")
  }
}