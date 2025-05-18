import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String }

  connect() {
    this.timeout = null
    console.log("search connected")
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value.trim()
      if (!query) {
        this.resultsTarget.innerHTML = ""
        return
      }

      const url = `${this.urlValue}?search=${encodeURIComponent(query)}`

      fetch(url, {
        headers: { "Accept": "text/html" }
      })
        .then(response => {
          if (!response.ok) throw new Error("Network response was not ok")
          return response.text()
        })
        .then(html => {
          this.resultsTarget.innerHTML = html
        })
        .catch(() => {
          this.resultsTarget.innerHTML = "<p>Error loading results</p>"
        })
    }, 300)
  }
}
