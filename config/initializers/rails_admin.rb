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
  config.model 'Blog' do
    field :image
    field :title
    field :content do
      html_attributes do
        {:class => 'form-control tinymce'}
      end
    end
    field :event do
      associated_collection_cache_all false
    end
    field :user do
      associated_collection_cache_all false
    end
  end
  config.model 'Ticket' do
    edit do 
      field :title
      field :currency, :enum do
        enum do
          Money::Currency.table.map { |code, currency| ["#{code} - #{currency[:name]}", code.to_s] }.to_h
        end
      end
      
      field :event do
        associated_collection_cache_all false
      end

      field :user do
        associated_collection_cache_all false
      end
  
      include_all_fields
      exclude_fields :price
    end
  end

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
  config.model 'FormSectionField' do

    edit do 

      field :field_type , :enum do
        enum do
          [
            "text", "password", "checkbox", "radio", "file", "date",
            "email", "number", "tel", "url", "search", "range",
            "color", "datetime-local", "month", "week", "time",
            "button", "submit", "reset", "image", "hidden" ,"select"
          ]
        end
      end 
      field :data_field , :enum do
        enum do
          User.column_names
        end
      end 
      include_all_fields
    end
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
    exclude_fields :favorited ,:favorited_ids
    edit do
      field :title
      field :category do
        associated_collection_cache_all false
      end
      field :ticket do
        associated_collection_cache_all false
      end

      include_all_fields

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
