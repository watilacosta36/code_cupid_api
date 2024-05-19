# frozen_string_literal: true

class CreateDislike
  include Interactor

  def call
    context.dislike.save!
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(message: e.message)
  end
end