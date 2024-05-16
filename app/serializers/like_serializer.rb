# frozen_string_literal: true

class LikeSerializer < Panko::Serializer
  attributes :user_id, :likeable_type, :likeable_id, :dislike
end