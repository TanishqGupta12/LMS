class BlogController < ApplicationController

  def index
        @event = Event.find_by(id: params[:event_id])
      @blogs = Blog.where(event_id:  @event.try(:id) ).order(:created_at)
  end
  
  def show
    @blogs = Blog.where(event_id:  params[:event_id] ).order(:created_at)
    @blog = Blog.find(params[:id] )
  end
end