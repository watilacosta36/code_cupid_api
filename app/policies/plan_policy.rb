# frozen_string_literal: true

class PlanPolicy < ApplicationPolicy
  def index?
    user_confirmed?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
