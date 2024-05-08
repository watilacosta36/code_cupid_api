# frozen_string_literal: true

class UserImagePolicy < ApplicationPolicy
  attr_reader :attachment

  def initialize(user, attachment)
    super(user, attachment.record)
    @attachment = attachment
  end

  def create?
    user.admin? || (user == attachment.record && user_confirmed?)
  end
end
