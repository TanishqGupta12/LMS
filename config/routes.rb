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
  match "/:event_id/blog", to: "home#blog", as: "blog", via: [:get, :post]


  match "/:event_id/terms_and_conditions", to: "home#terms_and_conditions", as: "terms_and_conditions", via: [:get, :post]
  match "/:event_id/privacy", to: "home#privacy", as: "privacy", via: [:get, :post]
  match "/:event_id/category", to: "home#category", as: "category", via: [:get, :post]

  resources :users do
    member do
      match "user_payment_info", to: "users#user_payment_info", as: "payment_info", via: [:get, :post]
    end
  end
  
  scope "/:event_id", as: "event" do
    resources :contact
    resources :teacher
    resources :course
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
