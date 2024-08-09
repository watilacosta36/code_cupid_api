# frozen_string_literal: true

module Api
  module V1
    class LikesController < BaseController
      def create
        reaction = authorize Like.new(like_params)
        result = Organizers::LikeUser.call(reaction:)

        return render_success(result.reaction) if result.success?

        render_errors(result)
      end

      def dislike
        reaction = authorize Like.new(like_params)
        Organizers::DislikeUser.call(reaction:)

        reaction.save ? render_success(reaction) : render_errors(reaction)
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
