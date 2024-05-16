# frozen_string_literal: true

class CheckMatch
  include Interactor

  def call
    return unless matched?

    context.match = Match.new(
      user_id: context.like.user_id,
      matched_user_id: context.like.likeable_id,
      matched_at: Time.zone.now
    )

    context.match.save!
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(message: e.message)
  end

  private

  def matched?
    Like.find_by(
      likeable_id: context.like.user_id,
      user_id: context.like.likeable_id,
      likeable_type: 'User',
      dislike: false
    )
  end
end