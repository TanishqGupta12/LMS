import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['container']; // only one target now

  connect() {
    console.log("user_note controller connected");

    toastr.options = {
      closeButton: true,
      progressBar: true,
      timeOut: "5000",
      extendedTimeOut: "1000",
      positionClass: "toast-top-right",
      preventDuplicates: true,
    };
  }

  
  submit(event) {
    event.preventDefault();

    const button = event.currentTarget;

    const userId = button.dataset.userId;
    const course = button.dataset.lessonId;
    const timestamp = button.dataset.timestamp;
    const notesId = button.dataset.notesId; // Get the notes ID
    
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    $.ajax({
      url: `/users/${userId}/note_detail`,
      method: "GET",
      dataType: "json",
      data: {
        notesId: notesId,
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
              <div class="container">
                <div class="form-group mb-3">
                  <label for="course_title">Course Title</label>
                  <p class="form-text text-muted border rounded p-2">${response.notes?.course_title}</p>
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
                  <input class="form-control" type="text" name="subject" id="subject" value="${response.notes.subject}" />
                </div>

                <div class="form-group mb-3">
                  <label for="description">Description</label>
                  <textarea class="form-control" type="text" name="description" id="description">
                  ${response.notes.description}
                  </textarea>
                </div>

                <input type="hidden" id="note_lesson_id" value="${response.notes.lesson_id}" />
                <input type="hidden" id="note_user_id" value="${response.notes.id}" />
                <input type="hidden" id="user_id" value="${response.notes.user_id}" />

                <button class="btn btn-primary px-4" data-action="click->user-note#update">Update Note</button>
              </div>
            </div>
          </div>
        `;

        this.containerTarget.innerHTML = formHTML;
      },
      error: (xhr) => {
        toastr.warning(xhr.responseText || "Could not fetch note.");
        console.error(xhr.responseText);
      }
    });
  }

  update(event) {
    event.preventDefault();

    const note = document.querySelector('#note_user_id').value;
    const user_id = document.querySelector('#user_id').value;
    const lessonId = document.querySelector('#note_lesson_id').value;
    const subject = document.querySelector('#subject').value;
    const description = document.querySelector('#description').value;

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    $.ajax({
      url: `/user_notes/${note}`,
      method: "PATCH",
      dataType: "json",
      headers: {
        'X-CSRF-Token': csrfToken
      },
      data: {
        id: note,
        lesson_id: lessonId,
        subject: subject,
        description: description,
        user_id: user_id
      },
      success: (response) => {
        toastr.success("Note updated successfully.");
        // Optional: re-fetch or refresh part of the page
      },
      error: (xhr) => {
        toastr.error("Failed to update the note.");
        console.error(xhr.responseText);
      }
    });
  }
}