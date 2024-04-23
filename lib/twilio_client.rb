class TwilioClient
  TWILIO_ACCOUNT_SID = 'ACc372075564976c8e0ed6db61529804dc' # Todo: Move to secure location
  TWILIO_AUTH_TOKEN = '1b91f71980bde68bb20a79c940cdc97c' # Todo: Move to secure location
  TWILIO_PHONE_NUMBER = '+12562724503' # Todo: Move to secure location

  def initialize
    @client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
  end

  def send_message(to, body)
    @client.messages.create(
      from: TWILIO_PHONE_NUMBER,
      to: to,
      body: body
    )
  end
end
