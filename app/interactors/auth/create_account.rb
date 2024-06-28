# frozen_string_literal: true

module Auth
  class CreateAccount
    include Interactor

    before do
      context.users = []
    end

    def call
      user = User.new(context.params)
      user.save!

      context.users << user
    rescue ActiveRecord::RecordInvalid => e
      context.fail!(error: e.message)
    end
  end
end
