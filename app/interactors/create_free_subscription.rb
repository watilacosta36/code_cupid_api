# frozen_string_literal: true

class CreateFreeSubscription
  include Interactor

  before do
    context.free_plan_id = Plan.find_by(price: 0.0).id

    context.subscription = Subscription.new(
      start_date: Date.today,
      end_date: Date.today.next_year,
      user_id: context.user.id,
      plan_id: context.free_plan_id
    )
  end

  def call
    context.subscription.save!
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(error: e.message)
  end
end