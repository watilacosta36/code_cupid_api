# frozen_string_literal: true

module Organizers
  class ResendConfirmCode
    include Interactor::Organizer

    organize Auth::SendConfirmationCode,
             Auth::UpdateConfirmationCode
  end
end
