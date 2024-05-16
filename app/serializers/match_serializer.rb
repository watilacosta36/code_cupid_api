# frozen_string_literal: true

class MatchSerializer < Panko::Serializer
  attributes :user_id,  :matched_user_id, :matched_at
end
