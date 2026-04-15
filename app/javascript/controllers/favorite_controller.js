import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite"
export default class extends Controller {
  static targets = [ "event", "course", "statusContainer" ]
  connect() {
    console.log("hello 1");
  }

  favorite(event) {
    event.preventDefault()
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const eventId = this.eventTarget.value
    const courseId = this.courseTarget.value

    $.ajax({
      url: `/${eventId}/course/${courseId}/course_favoritor`,
      method: "POST",
      dataType: "html",
      headers: {
        'X-CSRF-Token': csrfToken 
      },
      success: (html) => {
        this.statusContainerTarget.innerHTML = html
      },
      error: (xhr) => {
        alert("Error: " + xhr.responseText)
        console.log(xhr.responseText);
        
      }
    })
  }
}
