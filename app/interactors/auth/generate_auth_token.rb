# frozen_string_literal: true

module Auth
  class GenerateAuthToken
    include Interactor

    def call
      context.token = JwtToken.encode(user_id: context.user.id)
    rescue JWT::EncodeError => e
      context.fail!(error: e)
    end
  end
end
