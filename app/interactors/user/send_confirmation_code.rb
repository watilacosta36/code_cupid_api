# frozen_string_literal: true

class User::SendConfirmationCode
  include Interactor

  def call
    context.code = SecureRandom.alphanumeric(4)
    TwilioMessageJob.perform_async(context.user.phone_number, context.code)
  rescue Twilio::REST::RestError => e
    context.fail!(error: e.message)
  end

  private

  def rollback
    context.user.destroy
  end
end
