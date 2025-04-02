class ApplicationController < ActionController::Base

  layout :layout_by_resource
  before_action :load_events # Ensures @event is always set
  before_action :reload_rails_panel
  # after_action :reload_rails_panel

  def layout_by_resource
    if devise_controller?
      "devise/sessions"
    else
      "application"
    end
  end

  def get_host
    request.remote_ip # Alternative: request.host
  end

  def load_events
    # @event = Event.all.first
    
    @event = Event.find_by(location: get_host)
    
    if !@event.present?
      render json: { message: "Found not" }, status: :not_found and return
    end
    session[:event_id] =  @event.try(:id)
  end


  def after_sign_in_path_for(resource)
    if resource.superadmin? || resource.admin? || resource.teacher?
      rails_admin_path # Uses RailsAdmin dashboard path
    else
      root_path # Uses the application's root path
    end
  end

  def reload_rails_panel
    event_id = session[:event_id] # Store session value in a variable before config
  
    RailsAdmin::Config.reset_model(User)
    RailsAdmin.config do |config| 
      config.model 'User' do
        list do 
          field :image
          field :first_name
          field :last_name
          field :email
          field :password
          field :current_event_id, :enum do
            enum do
              Event.pluck(:id)
            end
          end
          field :role
        end
        edit do
          field :image
          field :email
          field :password
          field :current_event_id, :enum do
            enum do
              Event.pluck(:id)
            end
          end
  
          # Use the local variable instead of session[:event_id]
          FormSectionField.list_of_fields(event_id).each do |lf|
            if lf.data_field.present?
              debugger
              field lf.data_field.to_sym do 
                label lf.caption.try(:html_safe).to_s
                help lf.field_hint.try(:html_safe).to_s
              end
            end
          end
  
          field :role
          field :courses
        end
      end
    end
  end

end
