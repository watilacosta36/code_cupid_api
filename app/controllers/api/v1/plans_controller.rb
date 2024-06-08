# frozen_string_literal: true

module Api
  module V1
    class PlansController < BaseController
      def index
        authorize Plan
        plans = Plan.where.not(price: 0.0)
        plans_serialized = Panko::ArraySerializer.new(plans, each_serializer: PlanSerializer).to_json

        render json: plans_serialized, status: :ok
      end
    end
  end
end
