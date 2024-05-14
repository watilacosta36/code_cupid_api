Rails.application.routes.draw do
  if Rails.env.development?
    get 'up' => 'rails/health#show', as: :rails_health_check
  end

  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :users, only: %i[index update]
      end

      post 'auth/sign_up', to: 'auth#sign_up'
      post 'auth/login', to: 'auth#login'
      patch 'auth/confirm_account', to: 'auth#confirm_account'
      post 'auth/resend_code', to: 'auth#resend_code'

      post 'users_images/create'

      resources :likes, only: %i[create]
    end
  end
end
