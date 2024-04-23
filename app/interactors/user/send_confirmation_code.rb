# frozen_string_literal: true

class User::SendConfirmationCode
  include Interactor

  def call
    code = SecureRandom.alphanumeric(4)

    twilio_client = TwilioClient.new
    response = twilio_client.send_message(context.user.phone_number, "Your confirmation code is: #{code}")

    context.fail!(error: response.error_message) unless response.success?
  end

  def rollback
    context.user.destroy
  end
end