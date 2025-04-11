Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => {  :confirmations => "confirmations", :passwords => "passwords" ,registrations: 'registrations', sessions: 'sessions' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  post '/tinymce_assets' => 'tinymce#create'
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  match "/:event_id/login", to: "home#login", as: "login", via: [:get, :post]
  match "/:event_id/sign_up", to: "home#sign_up", as: "sign_up", via: [:get, :post]
  match "/:event_id/about", to: "home#about", as: "about", via: [:get, :post]
  match "/search", to: "home#search", as: "search", via: [:get, :post]
  # match "/:event_id/blog", to: "home#blog", as: "blog", via: [:get, :post]


  match "/:event_id/terms_and_conditions", to: "home#terms_and_conditions", as: "terms_and_conditions", via: [:get, :post]
  match "/:event_id/privacy", to: "home#privacy", as: "privacy", via: [:get, :post]
  match "/:event_id/category", to: "home#category", as: "category", via: [:get, :post]

  resources :users do
    member do
      match "user_payment_info", to: "users#user_payment_info", as: "payment_info", via: [:get, :post]
      match "update_email", to: "users#update_email", as: "update_email", via: [:put]
    end
  end
  
  scope "/:event_id", as: "event" do
    resources :contact
    resources :teacher
    resources :course do
      member do
        match "course_favoritor", to: "course#course_favoritor", as: "course_favoritor", via: [:get, :post]
      end
      resources :comments, only: [:create, :destroy]
    end
    resources :blog do
      resources :comments, only: [:create, :destroy]
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
