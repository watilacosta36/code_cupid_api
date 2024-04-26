class TwilioMessageJob
  include Sidekiq::Job

  def perform(phone_number, code)
    twilio_client = TwilioClient.new
    message = twilio_client.send_message(phone_number, "Your confirmation code is: #{code}")

    TwilioMessage.create!(phone_number:, twilio_message_sid: message.sid) if message.sid
  rescue Twilio::REST::RestError => e
    Rails.logger.error(e)
  end
end
