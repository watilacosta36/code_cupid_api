# frozen_string_literal: true

module Api
  module V1
    class PlansController < BaseController
      def index
        authorize Plan
        plans_serialized = Panko::ArraySerializer.new(Plan.all, each_serializer: PlanSerializer).to_json

        render json: plans_serialized, status: :ok
      end
    end
  end
end
