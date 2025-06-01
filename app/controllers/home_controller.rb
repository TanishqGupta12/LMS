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
    
    @form = Form.includes(form_sections: { form_section_fields: :form_field_choices }).find_by(event_id: params[:event_id])

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

    @event =  load_events #Event.find_by(id: params[:event_id])
    query = "%#{params[:search].to_s.downcase}%"

    blog = Blog.where("LOWER(title) LIKE :query OR LOWER(content) LIKE :query", query: query)

    courses = Course.where("is_active = true AND (LOWER(title) LIKE :query OR LOWER(tags) LIKE :query OR LOWER(overview) LIKE :query OR LOWER(language) LIKE :query)", query: query)

    teacher = User.includes(:role).where("LOWER(CONCAT(first_name, ' ', last_name)) LIKE :query OR LOWER(first_name) LIKE :query OR LOWER(last_name) LIKE :query", query: query).where(roles: { name: 'teacher' })

      tabs = {
        courses:  { label: "Courses",   data: courses },
        teachers: { label: "Teachers",  data: teacher },
        blogs:    { label: "Blogs",     data: blog }
      }

      render partial: "home/search_global", locals: { tabs: tabs, event: @event }
      
    # else params[:search] == '' && params[:search].nil?
    #   redirect_back fallback_location: root_path
    end
  end

  # def blog
  #   @event =  load_events #Event.find_by(id: params[:event_id])
  #   @blogs = Blog.where(event_id:  @event.try(:id) ).order(:created_at)
  # end

  def cancel
      @user = User.find(params[:id])
      @user.f13 = "unPaid"
      @user.save
  end


  def success
    @user = User.find(params[:id])
    @user.f13 = "Paid"
    @user.save
  end
  
end
