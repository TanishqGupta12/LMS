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

  private

  def user_note_params
    params.permit(:user_id, :event_id, :course_id, :subject, :description ,:timestamp ,:lesson_id)
  end
end
