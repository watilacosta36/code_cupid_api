# frozen_string_literal: true

class UserProfilePolicy < ApplicationPolicy
  attr_reader :user, :user_profile

  def initialize(user, user_profile)
    @user = user
    @user_profile = user_profile
  end

  def show?
    user.id.eql?(user_profile.id)
  end

  def update?
    show?
  end
end
