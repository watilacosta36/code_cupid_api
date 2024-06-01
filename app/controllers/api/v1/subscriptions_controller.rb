# frozen_string_literal: true

module Api
  module V1
    class SubscriptionsController < BaseController
      def create
        subscription = authorize Subscription.new(subscription_params)

        if subscription.save
          render json: { subscription: }, status: :created
        else
          render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def subscription_params
        params.require(:subscription).permit(:start_date, :end_date, :plan_id, :user_id)
      end
    end
  end
end
