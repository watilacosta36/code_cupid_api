# frozen_string_literal: true

class User::UpdateConfirmationCode
  include Interactor

  def call
    raise ActiveModel::MissingAttributeError, I18n.t('activerecord.errors.messages.invalid_code') unless context.code.present?

    context.user.update_attribute(:confirmation_code, context.code)
  rescue ActiveModel::MissingAttributeError => e
    context.fail!(error: e.message)
  end
end
