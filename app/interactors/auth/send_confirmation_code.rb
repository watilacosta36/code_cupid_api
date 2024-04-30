# frozen_string_literal: true

module Auth
  class SendConfirmationCode
    include Interactor

    before do
      context.code = SecureRandom.alphanumeric(4)
    end

    def call
      TwilioMessageJob.perform_async(context.user.phone_number, context.code)
    end
  end
end
