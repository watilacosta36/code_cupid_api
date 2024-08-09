# frozen_string_literal: true

module Api
  module V1
    class UsersImagesController < BaseController
      def create
        result = CreateUserImage.call(params:)

        if result.success?
          authorize result.attachment, policy_class: UserImagePolicy
          json_response(result.user, params)
        else
          render json: { message: result.message },
                 status: :unprocessable_entity unless result.success?
        end
      end

      private

      def json_response(user, params)
        attach_image_result = AttachImage.call(user:, images: params[:images])

        return render json: { message: I18n.t('activerecord.attributes.user.images.create.error') },
               status: :unprocessable_entity unless attach_image_result.success?

        render json: { message: I18n.t('activerecord.attributes.user.images.create.success') }, status: :ok
      end
    end
  end
end
