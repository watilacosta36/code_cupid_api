# frozen_string_literal: true

module Api
  module V1
    class TimelineController < BaseController
      include RenderJson

      def index
        result = search_users

        if result.success?
          authorize_users(result.users)
          render_json_response(data: serialize_users(result.users))
        else
          render_json_response(data: { error: result.errors }, status: :unprocessable_entity)
        end
      end

      private

      def serialize_users(users)
        Panko::ArraySerializer.new(
          users,
          each_serializer: TimelineSerializer
        ).to_json
      end

      def search_users
        UsersSearch.call(params: query_params, current_user:)
      end

      def authorize_users(users)
        authorize users, policy_class: TimelinePolicy
      end

      def query_params
        params.require(:timeline).permit(:search, :min_age, :max_age, :gender, :page)
      end
    end
  end
end
