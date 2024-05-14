# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      before_action :authorize_resource

      def create
        like = authorize Like.new(like_params)

        if like.save
          render json: { like:}, status: :created
        else
          render json: { errors: like.errors }, status: :unprocessable_entity
        end
      end

      private

      def like_params
        params.require(:like).permit(:likeable_id, :likeable_type, :user_id)
      end
    end
  end
end
