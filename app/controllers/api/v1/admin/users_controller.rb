# frozen_string_literal: true

module Api
  module V1
    module Admin
      class UsersController < BaseController
        def index
          authorize User
          users = User.select(:email, :phone_number, :username, :gender, :role)

          render json: { users: }, status: :ok
        end

        private

        def user_params
          params.require(:user).permit(
            :email,
            :phone_number,
            :username,
            :bio,
            :birthdate,
            :gender,
            :role,
            images: []
          )
        end
      end
    end
  end
end
