# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  end_date   :date             not null
#  start_date :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_plan_id  (plan_id)
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (user_id => users.id)
#
class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates :plan, presence: true
  validates :user, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
