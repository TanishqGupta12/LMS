class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment added successfully."
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      flash[:notice] = "Comment deleted."
    else
      flash[:alert] = "You can't delete this comment."
    end

    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :blog_id, :course_id, :parent_id)
  end
end
