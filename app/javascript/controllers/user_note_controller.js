import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['user','lesson', "container"]
  
    connect() {
      console.log("use_note");
  
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
        const lesson = this.lessonTarget.value
        $.ajax({
          url: `/review`,
          method: "POST",
          dataType: "html",
          data : {
            id: userId,
            lesson: lesson,
  
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