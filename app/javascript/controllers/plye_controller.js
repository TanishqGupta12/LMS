import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="plye" course details
export default class extends Controller {
  static targets = ["lesson" , "courseContainer" , "eventId", "courseId"]

  connect() {
    console.log("plye controller connected");

    toastr.options = {
      closeButton: true,
      progressBar: true,
      timeOut: "5000",
      extendedTimeOut: "1000",
      positionClass: "toast-top-right",
      preventDuplicates: true,
    }
  }

  video_player(event) {
    event.preventDefault()
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;


    // const id = event.currentTarget.dataset.lessonId;
    // console.log("Selected lesson ID:", id);

    const eventId = this.eventIdTarget.value
    const courseId = this.courseIdTarget.value

    $.ajax({
        url: `/${eventId}/course/${courseId}/`,
        method: "GET",
        dataType: "html",
        data : {
          lesson: event.currentTarget.dataset.lessonId
        },
        headers: {
          'X-CSRF-Token': csrfToken 
        },
        success: (html) => {
          this.courseContainerTarget.innerHTML = html
          // toastr.success("Lesson clicked!");
        },
        error: (xhr) => {
          alert("Error: " + xhr.responseText)
          console.log(xhr.responseText);
          
        }
      })
  }

}
