# frozen_string_literal: true

class TwilioClient
  TWILIO_ACCOUNT_SID = Rails.application.credentials.dig(:development, :twilio, :account_sid)
  TWILIO_AUTH_TOKEN = Rails.application.credentials.dig(:development, :twilio, :auth_token)
  TWILIO_PHONE_NUMBER = Rails.application.credentials.dig(:development, :twilio, :phone_number)

  def initialize
    @client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
  end

  def send_message(to, body)
    @client.messages.create(
      from: TWILIO_PHONE_NUMBER,
      to:,
      body:
    )
  end
end
