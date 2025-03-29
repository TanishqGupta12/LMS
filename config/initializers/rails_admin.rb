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
  config.model 'FormSection' do
    visible false
  end
  config.model 'Event' do

    edit do 
      field :location do

      end
      field :terms_and_conditions do
          html_attributes do
            {:class => 'form-control tinymce'}
          end
      end
      include_all_fields
      field :gallery ,:active_storage do
        # pretty_value do
        #   bindings[:object].gallery.map do |img|
        #     "<img src='#{Rails.application.routes.url_helpers.url_for(img)}' style='max-width: 100px; max-height: 100px;'>".html_safe
        #   end.join(' ').html_safe
        # end

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
