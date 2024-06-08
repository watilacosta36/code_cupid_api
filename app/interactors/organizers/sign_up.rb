# frozen_string_literal: true

module Organizers
  class SignUp
    include Interactor::Organizer

    organize Auth::CreateAccount,
             Auth::SendConfirmationCode,
             Auth::UpdateConfirmationCode,
             CreateFreeSubscription
  end
end
