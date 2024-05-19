# frozen_string_literal: true

module Organizers
  class DislikeUser
    include Interactor::Organizer

    organize CreateDislike,
             CheckMatch,
             Unmatch
  end
end