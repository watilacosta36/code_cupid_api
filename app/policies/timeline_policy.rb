# frozen_string_literal: true

class TimelinePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user_confirmed?
  end
end