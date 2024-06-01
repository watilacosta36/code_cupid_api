# == Schema Information
#
# Table name: plans
#
#  id                 :bigint           not null, primary key
#  duration_in_months :integer          not null
#  name               :string           not null
#  price              :decimal(10, 2)   not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Plan < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions

  validates :name, presence: true, uniqueness: true
  validates :duration_in_months, presence: true, numericality: { integer_only: true }
  validates :price, presence: true, numericality: true
end
