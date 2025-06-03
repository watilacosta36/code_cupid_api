# frozen_string_literal: true

class ConfirmMessageJob < ApplicationJob
  queue_as :default

  def perform(phone_number, code)
    ConfirmMessageService.new.call(phone_number, code)
  end
end
