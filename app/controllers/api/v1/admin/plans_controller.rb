# frozen_string_literal: true

module Api
  module V1
    module Admin
      class PlansController < BaseController
        def index
          authorize([:admin, Plan])
          plans = Plan.select(:id, :name, :duration_in_months, :price)

          render json: { plans: }, status: :ok
        end

        def create
          plan = authorize([:admin, Plan.new(plans_params)])

          render_response(plan)
        end

        private

        def plans_params
          params.require(:plan).permit(:name, :duration_in_months, :price)
        end

        def render_response(plan)
          if plan.save
            render json: { plan: }, status: :created
          else
            render json: { errors: plan.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
