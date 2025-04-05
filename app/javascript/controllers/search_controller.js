import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String }

  connect() {
    this.timeout = null
  }

    search() {

        if (!window.location.href.includes("/search")) {
            setTimeout(() => {
                window.location.href = 'http://127.0.0.1:3000/search';
              });
        }
        clearTimeout(this.timeout)
    
        this.timeout = setTimeout(() => {
        const query = this.inputTarget.value.trim()
        if (!query) return
    
        const url = `${this.urlValue}?search=${encodeURIComponent(query)}`
    
        fetch(url, {
            headers: { "Accept": "text/html" }
        })
            .then(response => response.text())
            .then(html => {
            this.resultsTarget.innerHTML = html
            })
        }, 300)
    }

    redirected() {
        

    }
}
