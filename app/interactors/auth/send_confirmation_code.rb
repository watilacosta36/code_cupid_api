# frozen_string_literal: true

module Auth
  class SendConfirmationCode
    include Interactor

    before do
      context.code          = SecureRandom.alphanumeric(4)
      context.phone_number  = context.user.phone_number
      context.twilio_client = TwilioClient.new
    end

    def call
      TwilioConfirmMessageJob.perform_now(
        context.phone_number,
        context.code,
        context.twilio_client
      )
    end
  end
end
