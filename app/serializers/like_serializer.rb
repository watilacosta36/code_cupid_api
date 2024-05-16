# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  dislike       :boolean          default(FALSE), not null
#  likeable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likeable_id   :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  idx_on_user_id_likeable_type_likeable_id_dislike_9be12ba30e  (user_id,likeable_type,likeable_id,dislike) UNIQUE
#  index_likes_on_likeable                                      (likeable_type,likeable_id)
#  index_likes_on_user_id                                       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class LikeSerializer < Panko::Serializer
  attributes :user_id, :likeable_type, :likeable_id, :dislike
end
