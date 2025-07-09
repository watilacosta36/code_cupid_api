module Auth
  class AuthenticateUser
    include Interactor

    def call
      context.user&.authenticate(context.password)
      context.users = [context.user]

    rescue BCrypt::Errors::InvalidHash => e
      context.fail!(error: I18n.t("auth.failure"))
    end
  end
end
