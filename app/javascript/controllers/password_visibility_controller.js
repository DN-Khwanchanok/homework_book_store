import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "button"]

  connect() {
    this.hide()
    this.buttonTarget.hidden = false
  }

  toggle() {
    const show = this.inputTarget.type === "password"
    this.inputTarget.type = show ? "text" : "password"
    this.buttonTarget.setAttribute("aria-pressed", String(show))
  }

  hide() {
    this.inputTarget.type = "password"
    this.buttonTarget.setAttribute("aria-pressed", "false")
  }
}
