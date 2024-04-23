# frozen_string_literal: true

class EmailValidator < ActiveModel::Validator
  def validate(record)
    return unless record.email.present?

    unless record.email.match?(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)
      record.errors.add(:email, t('activerecord.attributes.user.email.invalid_format'))
    end
  end
end
