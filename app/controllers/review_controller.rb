class ReviewController < ApplicationController

  def create
    review = Review.new(
      user_id: params[:userId],
      course_id: params[:courseId],
      rating: params[:rate],
      comment: params[:review]
    )

    if review.save
      render plain: "Review created successfully", status: :created
    else
      render plain: review.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end
end
