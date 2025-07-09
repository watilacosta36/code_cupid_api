# frozen_string_literal: true

class SmsClient
  def self.default
    TwilioClient.new # or Rails.configuration.sms_client_class.new
  end
end
