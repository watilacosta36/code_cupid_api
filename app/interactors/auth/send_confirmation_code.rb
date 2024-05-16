# frozen_string_literal: true

module Auth
  class SendConfirmationCode
    include Interactor

    before do
      context.code = SecureRandom.alphanumeric(4)
      context.phone_number = context.user.phone_number
    end

    def call
      TwilioConfirmMessageJob.perform_later(
        context.phone_number,
        context.code
      )
    end
  end
end
