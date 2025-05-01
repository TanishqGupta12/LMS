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
