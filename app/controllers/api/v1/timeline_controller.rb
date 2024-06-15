# frozen_string_literal: true

module Api
  module V1
    class TimelineController < BaseController
      def index
        result = UsersSearch.call(params: query_params)

        if result.success?
          authorize result.users, policy_class: TimelinePolicy

          render json: serialize_users(result.users), status: :ok
        else
          render json: { error: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def serialize_users(users)
        Panko::ArraySerializer.new(
          users,
          each_serializer: TimelineSerializer
        ).to_json
      end

      def query_params
        params.permit(:search, :age, :gender)
      end
    end
  end
end
