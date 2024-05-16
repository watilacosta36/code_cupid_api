# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  def create?
    user_confirmed? && record.user.eql?(user)
  end

  def dislike?
    create?
  end
end
