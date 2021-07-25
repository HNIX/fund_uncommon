import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "child", "open", "close" ]

  toggle() {
    this.childTarget.classList.toggle("hidden")
    this.openTarget.classList.toggle("hidden")
    this.closeTarget.classList.toggle("hidden")
  }
}