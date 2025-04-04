class BlogController < ApplicationController

  def index
      @blogs = Blog.includes(:category).where(event_id: params[:event_id]).order(:created_at)
      # @category =  @blogs
      @categorys =  Category.includes(:blogs).where(event_id: params[:event_id])
      
      @blogs_recenlty =  @blogs.limit(5)
      if params[:category_id].present? &&  params[:category_id] !="All"
        @blogs = @blogs.category_search(params[:category_id])
      end 

      if params[:tags].present? &&  params[:tags] !="All"
        @blogs = @blogs.tags_search(params[:tags])
      end
      @blogs = @blogs.page(params[:page]).per(6)
  end
  
  def show

    @blogs = Blog.includes(:category).where(event_id: params[:event_id]).order(:created_at)
    # @category =  @blogs
    @categorys =  Category.includes(:blogs).where(event_id: params[:event_id])
 
    @blogs_recenlty  =  @blogs.limit(5)
    @blog = Blog.find(params[:id] )
  end
end