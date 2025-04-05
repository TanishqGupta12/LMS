import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String }

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value
      const url = `${this.urlValue}?query=${encodeURIComponent(query)}`
      
      fetch(url, {
        headers: { "Accept": "text/vnd.turbo-stream.html" }
      })
      .then(response => response.text())
      .then(html => {
        this.resultsTarget.innerHTML = html
      })
    }, 300)
  }
}
