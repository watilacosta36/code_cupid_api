# frozen_string_literal: true

module Api
  module V1
    class LikesController < BaseController
      def create
        like = authorize Like.new(like_params)
        result = Organizers::LikeUser.call(like:)

        return render_success(result.like) if result.success?

        render_errors(result)
      end

      def dislike
        # dar dislike
        # verificar se tem match
        # se tiver match, deleta o match
        dislike = authorize Like.new(like_params)

        Organizers::DislikeUser.call(dislike:)

        dislike.save ? render_success(dislike) : render_errors(dislike)
      end

      private

      def render_success(reaction)
        response = LikeSerializer.new.serialize_to_json(reaction)

        render json: response, status: :created
      end

      def render_errors(reaction)
        render json: { errors: reaction.message }, status: :unprocessable_entity
      end

      def like_params
        params.require(:like).permit(:likeable_id, :likeable_type, :user_id, :dislike)
      end
    end
  end
end
