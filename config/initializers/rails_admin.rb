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
  config.show_gravatar = true
  # 
  #
  config.model 'Event' do

    navigation_label "Config"

    weight 0
    list do
      field :icon 
      field :description do
        visible false
      end 
      include_all_fields
      exclude_fields :description
    end

    edit do
      field :icon 
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

  config.model 'Banner' do

    navigation_label "Config"
    weight 2

    list do
      include_all_fields
    end
    edit do 
      include_all_fields
    end

  end

  config.model 'EmailContent' do

    navigation_label "Config"
    weight 3

    list do
      include_all_fields
    end
    edit do 
      include_all_fields
    end

  end

  config.model 'Blog' do
    navigation_label "More Link"
    weight 1
    field :category
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
    navigation_label "Ticket"
    weight 1
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
  config.model 'Discount' do

    navigation_label "Ticket"
    weight 2

    include_all_fields
  end

  config.model 'Form' do
    visible true

    navigation_label "Form"
    weight 1

  end

  config.model 'FormSection' do
    visible true

    navigation_label "Form"
    weight 2

  end

  config.model 'FormSectionField' do
    visible true

    navigation_label "Form"
    weight 3

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

  config.model 'FormFieldChoice' do
    visible true

    navigation_label "Form"
    weight 4

    edit do 

      include_all_fields
    end
  end


  config.model 'Course' do
    visible true

    navigation_label "Topic"
    weight 1

    list do
      field :level
      field :title
      field :tags
      field :is_active
      field :duration
      field :teacher do
        associated_collection_cache_all false
      end
      field :category do
        associated_collection_cache_all false
      end
      field :event do
        associated_collection_cache_all false
      end
      field :created_at
    end

    edit do
      field :level
      field :language
      field :title
      field :overview do
        html_attributes do
          {:class => 'form-control tinymce'}
        end
      end

      field :category do
        associated_collection_cache_all false
      end
      field :ticket do
        associated_collection_cache_all false
      end
      field :tags do
        label "Tags"
        help "Separate with commas, e.g. ruby, rails, backend"
      end


      field :event do
        associated_collection_cache_all false
      end
      field :teacher do
        associated_collection_cache_all false
      end
      include_all_fields
      exclude_fields :favorited ,:favorited_ids ,:comment_ids ,:comments
    end
  end

  config.model 'Lesson' do
    visible true

    navigation_label "Topic"
    weight 3
    edit do
    
      include_all_fields
      exclude_fields :content
    end
    list do

      include_all_fields
      exclude_fields :content
    end
  end

  config.model 'QuizTopic' do
    visible true
    navigation_label "Topic"
    weight 2
    edit do
    
      exclude_fields :category ,:catgory_id , :description
    end
    list do

      exclude_fields :category ,:catgory_id , :description
    end
  end

  config.model 'QuizQuestion' do
    visible true
    navigation_label "Topic"
    weight 4
    edit do
    
      exclude_fields :quiz_topic
    end
    list do

      exclude_fields :quiz_topic
    end
  end

  config.model 'QuizQuestionOption' do
    visible true
    navigation_label "Topic"
    weight 5
    edit do
    
    end
    list do

    end
  end

  config.model 'QuizAttempt' do
    visible true
    navigation_label "Topic"
    weight 6
    edit do
    
    end
    list do

    end
  end

  config.model 'QuizAttemptResult' do
    visible true
    navigation_label "Topic"
    weight 7
    edit do
    
      exclude_fields  :quiz_question , :quiz_question_option , :lesson
    end
    list do

      exclude_fields  :quiz_question , :quiz_question_option , :lesson
    end
  end

  config.model 'QuizResult' do
    visible true
    navigation_label "Topic"
    weight 8
    edit do
    
    end
    list do

    
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
