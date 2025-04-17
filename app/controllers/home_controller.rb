class HomeController < ApplicationController

  def index
    @event = Event.includes(:banners).find_by(location: get_host)
    @caraousel_data = @event.try(:banners)
    @categories_data = Category.includes(:courses).where(event_id: @event.try(:id))
    @teacher_data =  User.teachers_for_event(@event.id)
    @courses = Course.includes(:ticket).where(event_id: @event.id)
  end

  def login
    
  end

  def category
    
  end

  def sign_up
    # @form = Form
    # .includes(:form_sections , )
    # .includes(form_section_fields: :form_field_choices) 
    # .find_by(event_id: params[:event_id])                      
    # 
    @form = Form
    .includes(form_sections: { form_section_fields: :form_field_choices })
    .find_by(event_id: params[:event_id])

  end
  def about
    @event =  load_events #Event.find_by(id: params[:event_id])
  end


  def course
    @event =  load_events #Event.find_by(id: params[:event_id])
  end

  def teacher
    @event =  load_events #Event.find_by(id: params[:event_id])
  end

  def terms_and_conditions
    @event =  load_events #Event.find_by(id: params[:event_id])
  end

  def privacy
    @event =  load_events #Event.find_by(id: params[:event_id])
  end

  def search
    if params[:search].present?

      redirect_to search_path()
      
    elsif params[:search] == '' && params[:search].nil?
      redirect_back fallback_location: root_path
    end
  end

  # def blog
  #   @event =  load_events #Event.find_by(id: params[:event_id])
  #   @blogs = Blog.where(event_id:  @event.try(:id) ).order(:created_at)
  # end

end
