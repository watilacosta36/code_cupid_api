# frozen_string_literal: true

class User::CreateAccount
  include Interactor

  def call
    user = User.new(context.params)

    context.user = user if user.save!
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(error: e.message)
  end
end
