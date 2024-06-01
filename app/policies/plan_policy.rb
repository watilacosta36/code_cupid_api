# frozen_string_literal: true

class PlanPolicy < ApplicationPolicy
  def index?
    user.admin? && user_confirmed?
  end

  def create?
    index?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
