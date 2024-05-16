# frozen_string_literal: true

module Organizers
  class LikeUser
    include Interactor::Organizer

    organize CreateLike,
             CheckMatch,
             NotifyUserMatch
  end
end