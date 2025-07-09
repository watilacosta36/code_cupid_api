# frozen_string_literal: true

module Auth
  class AuthenticateUser
    include Interactor

    def call
      context.user&.authenticate(context.password)
      context.users = [context.user]
    rescue BCrypt::Errors::InvalidHash
      context.fail!(error: I18n.t('auth.failure'))
    end
  end
end
