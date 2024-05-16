# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      before_action :authorize_resource

      def create
        like = authorize Like.new(like_params)
        like.save ? render_success(like) : render_errors(like)
      end

      def dislike
        dislike = authorize Like.new(like_params)
        dislike.save ? render_success(dislike) : render_errors(dislike)
      end

      private

      def render_success(reaction)
        response = LikeSerializer.new.serialize_to_json(reaction)

        render json: response, status: :created
      end

      def render_errors(reaction)
        render json: { errors: reaction.errors.full_messages }, status: :unprocessable_entity
      end

      def like_params
        params.require(:like).permit(:likeable_id, :likeable_type, :user_id, :dislike)
      end
    end
  end
end
