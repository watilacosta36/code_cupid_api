class Plan < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :duration_in_months, presence: true, numericality: { integer_only: true }
  validates :price, presence: true, numericality: true
end
