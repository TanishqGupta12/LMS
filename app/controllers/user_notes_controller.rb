class UserNotesController < ApplicationController

  def create
    @user_note = UserNote.new(user_note_params)
    if @user_note.save
      # flash[:notice] = "Note saved successfully"
      redirect_to fallback_location: request.referer , notice: "Successfully saved!"
    else
      redirect_to fallback_location: request.referer , alert: "Something went wrong."
    end
  end

  def update_notes
    debugger
    @user_note = UserNote.find_by(user_id: params[:id], lesson_id: params[:lesson_id])
  
    if @user_note
      if @user_note.update(subject: params[:subject], description: params[:description])
        # render json: { notice: 'success', message: 'Note updated successfully.' }
        
        respond_to do |format|
          format.js { 
            render json: { notes: @notes.as_json.merge({ lesson_title: @notes.lesson_title ,course_title: @notes.course_title  })}
          }
        end

      else
        render json: {
          notice: 'error',
          message: 'Failed to update note.',
          errors: @user_note.errors.full_messages
        }, status: :unprocessable_entity
      end
    else
      render json: { notice: 'error', message: 'Note not found.' }, status: :not_found
    end
  end
  
  def destroy
    @user_note = UserNote.find_by(user_id: params[:id], lesson_id: params[:lesson])

    if @user_note.present?
      @user_note.destroy
      respond_to do |format|
        format.html { redirect_to request.referer, notice: 'Note was successfully deleted.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referer, alert: 'Note not found.' }
        format.json { render json: { error: 'Note not found' }, status: :not_found }
      end
    end
  end
  

  private

  def user_note_params
    params.permit(:user_id, :event_id, :course_id, :subject, :description ,:timestamp ,:lesson_id)
  end
end
