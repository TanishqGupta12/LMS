import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review"
export default class extends Controller {
    static targets = [ "course", "user", "review", "rate" ]

  connect() {
    console.log("review");
    toastr.options = {
        "closeButton": true,
        "progressBar": true,
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "positionClass": "toast-top-right",
        "preventDuplicates": true,
      }
  }

  submit (event){
    event.preventDefault()

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const userId = this.userTarget.value
    const courseId = this.courseTarget.value 
    const review = this.reviewTarget.value
    const rate = this.rateTarget.value
    $.ajax({
      url: `/review`,
      method: "POST",
      dataType: "html",
      data : {
        userId: userId,
        courseId: courseId,
        review: review,
        rate: rate
      },
      headers: {
        'X-CSRF-Token': csrfToken 
      },
      success: (html) => {
        toastr.success("Review submitted successfully!");
        this.element.reset(); // optional: clear form
      },
      error: (xhr) => {
        toastr.warning(xhr.responseText)
        console.log(xhr.responseText);
        
      }
    })
  }
}