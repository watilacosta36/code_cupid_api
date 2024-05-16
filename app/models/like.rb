# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user, uniqueness: { scope: %i[likeable_id likeable_type dislike] }

  before_commit :destroy_existing_reaction

  private

  def destroy_existing_reaction
    existing_reaction = Like.find_by(
      user_id:,
      likeable_id:,
      likeable_type:,
      dislike: !dislike
    )

    return unless existing_reaction

    existing_reaction.destroy
  end

end
