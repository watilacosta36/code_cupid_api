# frozen_string_literal: true

module Api
  module V1
    class UsersImagesController < ApplicationController
      before_action :authorize_resource

      def create
        record = User.find(params[:user_id])
        attachment = ActiveStorage::Attachment.new(record:, name: :images)
        authorize attachment, policy_class: UserImagePolicy

        json_response(user, params)
      rescue ActiveRecord::RecordNotFound => e
        render json: { message: I18n.t('activerecord.models.user.not_found') }, status: :not_found
        Rails.logger.warn(e)
      end

      private

      def json_response(user, params)
        if attach_image(user, params[:images])
          render json: { message: I18n.t('activerecord.attributes.user.images.create.success') }, status: :ok
        else
          render json: { message: I18n.t('activerecord.attributes.user.images.create.error') },
                 status: :unprocessable_entity
        end
      end

      def attach_image(user, images)
        images.each do |img|
          decoded_img = Base64.decode64(img['image_data'])
          temp_file = build_temp_file(decoded_img)

          user.images.attach(io: temp_file, filename: "image_#{Time.now.to_i}.jpg", content_type: 'image/jpeg')
        ensure
          temp_file.close
          temp_file.unlink
        end
      end

      def build_temp_file(decoded_img)
        temp_file = Tempfile.new(%w[image_ .jpg], binmode: true)
        temp_file.write(decoded_img)
        temp_file.rewind
        temp_file
      end
    end
  end
end
