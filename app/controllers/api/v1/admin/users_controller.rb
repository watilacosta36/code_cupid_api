# frozen_string_literal: true

module Api
  module V1
    module Admin
      class UsersController < BaseController
        def index
          authorize User
          users = User.limit(100).includes([:images_attachments, { subscription: :plan }])

          render json: Panko::ArraySerializer.new(users, each_serializer: UserSerializer).to_json, status: :ok
        end

        def update
          authorize User

          result = UpdateUser.call(params: user_params.merge!(id: params[:id]))

          if result.success?
            render json: UserSerializer.new.serialize_to_json(result.user), status: :ok
          else
            render json: { error: I18n.t('activerecord.models.user.not_found') }
          end
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
