# frozen_string_literal: true

# == Schema Information
#
# Table name: twilio_messages
#
#  id                 :bigint           not null, primary key
#  phone_number       :string
#  twilio_message_sid :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class TwilioMessage < ApplicationRecord
  validates :phone_number, presence: true
  validates :twilio_message_sid, presence: true
end
