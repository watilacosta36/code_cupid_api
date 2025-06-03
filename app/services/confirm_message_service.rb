class ConfirmMessageService
  def initialize(client: SmsClient.default)
    @client = client
  end

  def call(phone_number, code)
    message = client.send_message(phone_number, I18n.t('sms.confirm_message', code:))

    TwilioMessage.create!(phone_number:, twilio_message_sid: message.sid) if message.sid
  rescue Twilio::REST::RestError => e
    Rails.logger.error(e)
  end

  private

  attr_reader :client
end