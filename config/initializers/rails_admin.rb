RailsAdmin.config do |config|
  config.asset_source = :importmap

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  # == CancanCan ==
  config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  # 
  #
  config.model 'Banner' do
    edit do 
      field :gallery do
        help "width 1366 and hieght 798"
      end 
      include_all_fields
    end

  end
  config.model 'FormSection' do
    visible false
  end
  config.model 'Event' do


    list do 
      field :description do
        visible false
      end 
      include_all_fields
      exclude_fields :description
    end

    edit do 
      exclude_fields :description
      field :description do
        visible false
      end 
      field :location do
        help "Enter the 127.0.0.1"
      end 
      field :time_zone, :enum do
        enum ActiveSupport::TimeZone.all.map { |tz| ["(UTC #{tz.formatted_offset}) #{tz.name}", tz.name] }
      end

      include_all_fields
      
      field :slug do
        # html_attributes do
        #   { class: 'form-control tinymce', style: 'height: 400px;' }
        # end
      end
      field :page_content do
        label "Privacy Page Content"
        html_attributes do
          {:class => 'form-control tinymce'}
        end
      end

      field :terms_and_conditions do
          html_attributes do
            {:class => 'form-control tinymce'}
          end
      end
      field :about_text do
        html_attributes do
          {:class => 'form-control tinymce'}
        end
      end
      field :gallery_text do
        html_attributes do
          {:class => 'form-control tinymce'}
        end
      end

    end
  end
  config.model 'Course' do
    visible true
    include_all_fields
    edit do
      field :event do
        associated_collection_cache_all false
      end
      field :teacher do
        associated_collection_cache_all false
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
