# frozen_string_literal: true

class User::UpdateConfirmationCode
  include Interactor

  def call
    context.user.update!(confirmation_code: context.code)
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(error: e.message)
  end
end
