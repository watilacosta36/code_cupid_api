# frozen_string_literal: true

class TwilioConfirmMessageJob < ApplicationJob
  queue_as :default

  def perform(phone_number, code, twilio_client)
    message = twilio_client.send_message(phone_number, I18n.t('twilio.confirm_message', code:))

    TwilioMessage.create!(phone_number:, twilio_message_sid: message.sid) if message.sid
  rescue Twilio::REST::RestError => e
    Rails.logger.error(e)
  end
end
