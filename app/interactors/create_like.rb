# frozen_string_literal: true

class CreateLike
  include Interactor

  def call
    context.like.save!
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(message: e.message)
  end
end