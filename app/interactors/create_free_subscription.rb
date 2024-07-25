# frozen_string_literal: true

class CreateFreeSubscription
  include Interactor

  before do
    context.free_plan_id = Plan.find_by(price: 0.0).id
    context.subscriptions = []
  end

  def call
    context.users.each do |user|
      next if user&.subscription.present?

      context.subscriptions << {
        start_date: Date.today,
        end_date: Date.today.next_year,
        user_id: user.id,
        plan_id: context.free_plan_id,
        created_at: DateTime.now,
        updated_at: DateTime.now,
        active: true
      }
    end

    Subscription.insert_all(context.subscriptions)
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(error: e.message)
  end
end
