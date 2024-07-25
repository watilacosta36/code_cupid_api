module Auth
  class AuthenticateUser
    include Interactor

    def call
      context.fail! unless context.user&.authenticate(context.password)
      context.users = [context.user]
    end
  end
end
