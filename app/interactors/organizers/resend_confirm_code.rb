# frozen_string_literal: true

module Organizers
  class ResendConfirmCode
    include Interactor::Organizer

    organize User::SendConfirmationCode,
             User::UpdateConfirmationCode
  end
end
