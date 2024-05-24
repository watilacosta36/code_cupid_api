# frozen_string_literal: true

# == Schema Information
#
# Table name: matches
#
#  id              :bigint           not null, primary key
#  matched_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  matched_user_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_matches_on_matched_user_id  (matched_user_id)
#  index_matches_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (matched_user_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class MatchSerializer < Panko::Serializer
  attributes :user_id,  :matched_user_id, :matched_at
end
