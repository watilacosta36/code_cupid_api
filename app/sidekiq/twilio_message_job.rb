class TwilioMessageJob
  include Sidekiq::Job

  def perform(phone_number, code)
    twilio_client = TwilioClient.new
    twilio_client.send_message(phone_number, "Your confirmation code is: #{code}")
  end
end
