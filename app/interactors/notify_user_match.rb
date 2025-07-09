# frozen_string_literal: true

class NotifyUserMatch
  include Interactor

  def call
    Rails.logger.warn('NOTIFICAR USUÁRIO SOBRE MATCH')
  end
end
