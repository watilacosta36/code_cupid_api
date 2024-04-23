# frozen_string_literal: true

module Organizers
  class SignUp
    include Interactor::Organizer

    organize ::User::CreateAccount, ::User::SendConfirmationCode
  end
end
