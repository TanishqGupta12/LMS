class BlogController < ApplicationController

  def index
      @blogs = Blog.includes(:category).where(event_id: params[:event_id]).order(:created_at)
      # @category =  @blogs
      @categorys =  Category.includes(:blogs).where(event_id: params[:event_id])
      
      @blogs_recenlty =  @blogs
      if params[:category_id].present? &&  params[:category_id] !="All"
        @blogs = @blogs.category_search(params[:category_id])
      end
  end
  
  def show

    @blogs = Blog.includes(:category).where(event_id: params[:event_id]).order(:created_at)
    # @category =  @blogs
    @categorys =  Category.includes(:blogs).where(event_id: params[:event_id])
 
    @blogs_recenlty = @blogs
    @blog = Blog.find(params[:id] )
  end
end