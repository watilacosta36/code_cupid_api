Rails.application.routes.draw do
  if Rails.env.development?
    get 'up' => 'rails/health#show', as: :rails_health_check
  end

  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :users, only: %i[index update]
      end

      #### AUTH START ####
      post 'auth/sign_up', to: 'auth#sign_up'
      post 'auth/login', to: 'auth#login'
      patch 'auth/confirm_account', to: 'auth#confirm_account'
      post 'auth/resend_code', to: 'auth#resend_code'
      #### AUTH END ####
      #
      #
      #### USERS_IMAGES START ####
      post 'users_images/create'
      #### USERS_IMAGES END ####
      #
      #
      #### LIKES START ####
      resources :likes, only: %i[create]
      #
      #
      post 'dislike', to: 'likes#dislike'
      #### LIKES END ####
      #
      #
      #### USER PROFILE START ####
      resources :user_profiles, only: %i[show update]
      #### USER PROFILE END ####
      #
      #
    end
  end
end
