# frozen_string_literal: true

module Api
  module V1
    module Admin
      class PlansController < BaseController
        def index
          authorize Plan
          plans = Plan.select(:id, :name, :duration_in_months, :price)

          render json: { plans: }, status: :ok
        end

        def create
          plan = authorize Plan.new(plans_params)

          if plan.save
            render json: { plan: }, status: :created
          else
            render json: { errors: plan.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def plans_params
          params.require(:plan).permit(:name, :duration_in_months, :price)
        end
      end
    end
  end
end
