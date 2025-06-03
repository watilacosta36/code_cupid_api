# frozen_string_literal: true

module Auth
  class SendConfirmationCode
    include Interactor

    before do
      context.code = SecureRandom.alphanumeric(4)
      context.phone_number = context.users.first.phone_number
    end

    def call
      ConfirmMessageJob.perform_later(
        context.phone_number,
        context.code
      )
    end
  end
end
