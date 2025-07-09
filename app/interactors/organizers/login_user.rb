# frozen_string_literal: true

module Organizers
  class LoginUser
    include Interactor::Organizer

    organize Auth::AuthenticateUser,
             CreateFreeSubscription,
             Auth::GenerateAuthToken
  end
end
