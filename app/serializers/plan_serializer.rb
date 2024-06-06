# frozen_string_literal: true

class PlanSerializer < Panko::Serializer
  attributes :id, :name, :duration_in_months, :price
end
