# frozen_string_literal: true

module Api
  module V1
    class UsersImagesController < BaseController
      def create
        result = CreateUserImage.call(user: find_user)
        authorize result.attachment, policy_class: UserImagePolicy

        return render json: {
          message: result.message
        }, status: :unprocessable_entity unless result.success?

        json_response(result.user, params)
      end

      private

      def find_user
        User.find_by(id: params[:user_id])
      end

      def json_response(user, params)
        attach_image_result = AttachImage.call(user:, images: params[:images])

        return render json: { message: I18n.t('activerecord.attributes.user.images.create.error') },
               status: :unprocessable_entity unless attach_image_result.success?

        render json: { message: I18n.t('activerecord.attributes.user.images.create.success') }, status: :ok
      end
    end
  end
end
