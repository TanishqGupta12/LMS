import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ['user', 'lesson', 'timestamp', 'container'];

    connect() {
        console.log("user_note");

        toastr.options = {
            "closeButton": true,
            "progressBar": true,
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "positionClass": "toast-top-right",
            "preventDuplicates": true,
        };
    }

    submit(event) {
        event.preventDefault();

        const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
        const userId = this.userTarget.value;
        const course = this.lessonTarget.value;
        const timestamp = this.timestampTarget.value;

        $.ajax({
            url: `/users/${userId}/note_detail`,
            method: "GET",
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
                toastr.success("User note fetched successfully!");

                const formHTML = `
                <div class="card mt-3 border p-3 col-9 mx-auto">
                  <div class="card-header bg-transparent border-bottom">
                    <h3 class="mb-0">My Notes Details</h3>
                  </div>
                  <div class="card-body">
                    <form id="update-note-form" data-action="submit->user-note#update" class="container">
                      <div class="form-group mb-3">
                        <label for="course_title">Course Title</label>
                        <p id="course_title" class="form-text text-muted border rounded p-2">${response.notes.course_title}</p>
                      </div>
              
                      <div class="form-group mb-3">
                        <label for="lesson_title">Lesson Title</label>
                        <p id="lesson_title" class="form-text text-muted border rounded p-2">${response.notes.lesson_title}</p>
                      </div>
              
                      <div class="form-group mb-3">
                        <label for="timestamp">Timestamp</label>
                        <p id="timestamp" class="form-text text-muted border rounded p-2">${response.notes.timestamp}</p>
                      </div>
              
                      <div class="form-group mb-3">
                        <label for="subject">Subject</label>
                        <input class="form-control" type="text" name="subject" id="subject" value="${response.notes.subject}" />
                      </div>
              
                      <div class="form-group mb-3">
                        <label for="description">Description</label>
                        <input class="form-control" type="text" name="description" id="description" value="${response.notes.description}" />
                      </div>
              
                      <input type="hidden" name="lesson_id" value="${response.notes.lesson_id}" />
                      <input type="hidden" name="user_id" value="${response.notes.user_id}" />
              
                      <input class="btn btn-primary px-4" value="Update Note" type="submit"/>
                    </form>
                  </div>
                </div>
              `;
              
                document.querySelector('.user_notes').innerHTML = formHTML;
            },
            error: (xhr) => {
                toastr.warning(xhr.responseText);
                console.log(xhr.responseText);
            }
        });
    }

    update(event) {
        event.preventDefault(); // Prevent the default form submission
        console.log('Update method triggered');  // Check if this logs in the console
        const form = event.target;
        const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
        const formData = $(form).serialize();  // Serialize the entire form data

        console.log("Form Data: ", formData);  // For debugging

        $.ajax({
            url: `/update_notes`,  // Assuming the user ID is a hidden field in the form
            method: "PATCH",
            dataType: "json",
            headers: {
                'X-CSRF-Token': csrfToken
            },
            data: formData,  // Send serialized data
            success: (response) => {
                toastr.success("Note updated successfully!");

                // Update the form with the latest response
                const formHTML = `
                <div class="card mt-3 border p-3 col-9 mx-auto">
                  <div class="card-header bg-transparent border-bottom">
                    <h3 class="mb-0">My Notes Details</h3>
                  </div>
                  <div class="card-body">
                    <form id="update-note-form" data-action="submit->user-note#update" class="container">
                      <div class="form-group mb-3">
                        <label for="course_title">Course Title</label>
                        <p id="course_title" class="form-text text-muted border rounded p-2">${response.notes.course_title}</p>
                      </div>
              
                      <div class="form-group mb-3">
                        <label for="lesson_title">Lesson Title</label>
                        <p id="lesson_title" class="form-text text-muted border rounded p-2">${response.notes.lesson_title}</p>
                      </div>
              
                      <div class="form-group mb-3">
                        <label for="timestamp">Timestamp</label>
                        <p id="timestamp" class="form-text text-muted border rounded p-2">${response.notes.timestamp}</p>
                      </div>
              
                      <div class="form-group mb-3">
                        <label for="subject">Subject</label>
                        <input class="form-control" type="text" name="subject" id="subject" value="${response.notes.subject}" />
                      </div>
              
                      <div class="form-group mb-3">
                        <label for="description">Description</label>
                        <input class="form-control" type="text" name="description" id="description" value="${response.notes.description}" />
                      </div>
              
                      <input type="hidden" name="lesson_id" value="${response.notes.lesson_id}" />
                      <input type="hidden" name="user_id" value="${response.notes.user_id}" />
              
                      <input class="btn btn-primary px-4" value="Update Note" type="submit"/>
                    </form>
                  </div>
                </div>
              `;
              
                document.querySelector('.user_notes').innerHTML = formHTML;  // Inject the updated form back into the DOM
            },
            error: (xhr) => {
                toastr.error("Failed to update the note.");
                console.error(xhr.responseText);
            }
        });
    }
}