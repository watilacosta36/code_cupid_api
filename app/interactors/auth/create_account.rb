# frozen_string_literal: true

module Auth
  class CreateAccount
    include Interactor

    def call
      user = User.new(context.params)

      context.user = user if user.save!
    rescue ActiveRecord::RecordInvalid => e
      context.fail!(error: e.message)
    end
  end
end
