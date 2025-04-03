class BlogController < ApplicationController

  def index
        @event = Event.find_by(id: params[:event_id])
      @blogs = Blog.where(event_id:  @event.try(:id) ).order(:created_at)
  end
  
  def show
    
  end
end