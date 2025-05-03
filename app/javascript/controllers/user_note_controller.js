import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['user', 'lesson', 'timestamp','container']

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

    submit(event) {
        event.preventDefault()

        const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
        const userId = this.userTarget.value
        const course = this.lessonTarget.value
        const timestamp = this.timestampTarget.value

        $.ajax({
            url: `/users/${userId}/note_detail`,
            method: "POST",
            dataType: "json",
            data: {
                id: userId,
                course: course,
                timestamp: timestamp
            },
            headers: {
                'X-CSRF-Token': csrfToken
            },
            success: (response) => {
              // console.log(response);

              // Assuming response contains the notes and event
                toastr.success("User note fetch successfully!");

                const formHTML = `
                <div class="card mt-3 border p-3 col-9" style="margin-left: 25%;">
                  <div class="card-header bg-transparent border-bottom">
                    <h3 class="mb-0">My Notes Details</h3>
                  </div>
                  <div class="card-body">
                    <form class="container">


                      <div class="form-group mb-3">
                        <label for="course_title">Course Title</label>
                        <p class="form-text text-muted border rounded p-2">${response.notes.course_title}</p>
                      </div>

                      <div class="form-group mb-3">
                        <label for="lesson_title">Lesson Title</label>
                        <p class="form-text text-muted border rounded p-2">${response.notes.lesson_title}</p>
                      </div>

                      <div class="form-group mb-3">
                        <label for="timestamp">Timestamp</label>
                        <p class="form-text text-muted border rounded p-2">${response.notes.timestamp}</p>
                      </div>

                      <div class="form-group mb-3">
                        <label for="subject">Subject</label>
                        <p class="form-text text-muted border rounded p-2">${response.notes.subject}</p>
                      </div>
              
                      <div class="form-group mb-3">
                        <label for="description">Description</label>
                        <p class="form-text text-muted border rounded p-2">${response.notes.description}</p>
                      </div>
                    </form>
                  </div>
                </div>
              `;
              
              document.querySelector('.user_notes').innerHTML = formHTML;
              // this.containerTarget.innerHTML = formHTML;
            },
            error: (xhr) => {
                toastr.warning(xhr.responseText)
                console.log(xhr.responseText);
            }
        })
    }
}