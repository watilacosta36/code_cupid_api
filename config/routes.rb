Rails.application.routes.draw do
  require 'sidekiq/web'

  if Rails.env.development?
    get 'up' => 'rails/health#show', as: :rails_health_check
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]

      post 'auth/sign_up', to: 'auth#sign_up'
      post 'auth/login', to: 'auth#login'
      patch 'auth/confirm_account', to: 'auth#confirm_account'
      post 'auth/resend_code', to: 'auth#resend_code'

      # Create user images
      post 'users_images/create'
    end
  end
end
