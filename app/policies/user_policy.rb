# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.admin? && user_confirmed?
  end

  def update?
    index?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
