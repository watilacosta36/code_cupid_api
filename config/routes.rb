Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check if Rails.env.development?

  namespace :api do
    namespace :v1 do
      resources :users
      post 'auth/sign_up', to: 'auth#sign_up'
      post 'auth/login', to: 'auth#login'
    end
  end
end
