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
class Match < ApplicationRecord
  belongs_to :user
  belongs_to :matched_user, class_name: 'User'

  validates :user, presence: true
  validates :matched_user, presence: true
  validates_uniqueness_of :user_id, scope: :matched_user_id
end
