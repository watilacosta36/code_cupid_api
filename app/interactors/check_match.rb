# frozen_string_literal: true

class CheckMatch
  include Interactor

  def call
    return unless matched?

    binding.pry
    context.match = Match.new(
      user_id: context.reaction.user_id,
      matched_user_id: context.reaction.likeable_id,
      matched_at: Time.zone.now
    )

    context.match.save!
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(message: e.message)
  end

  private

  def matched?
    Like.find_by(
      likeable_id: context.reaction.user_id, # current_user liked by likeable user
      user_id: context.reaction.likeable_id, # likeable user liked by current_user
      likeable_type: 'User',
      dislike: false
    )
  end
end
