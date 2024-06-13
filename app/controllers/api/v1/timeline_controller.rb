# frozen_string_literal: true

module Api
  module V1
    class TimelineController < BaseController
      def index
        users = User.search('*')

        authorize users, policy_class: TimelinePolicy

        serialized_users = Panko::ArraySerializer.new(
          users,
          each_serializer: TimelineSerializer
        ).to_json

        render json: serialized_users, status: :ok
      end
    end
  end
end
