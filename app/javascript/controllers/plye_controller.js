import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="plye" course details
export default class extends Controller {
  static targets = ["lesson"]

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
    // Remove 'active-plye' from all lesson blocks
    this.lessonTargets.forEach(el => {
      el.querySelector(".position-relative")?.classList.remove("active-plye");
    });

    // Add 'active-plye' to the clicked lesson's inner div
    event.currentTarget.querySelector(".position-relative")?.classList.add("active-plye");

    const id = event.currentTarget.dataset.lessonId;
    console.log("Selected lesson ID:", id);

    toastr.success("Lesson clicked!");
  }

}
