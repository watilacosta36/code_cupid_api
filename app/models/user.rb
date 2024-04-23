# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  birthdate    :date
#  email        :string
#  first_name   :string
#  gender       :string
#  last_name    :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class User < ApplicationRecord
  has_secure_password validations: false

  REGEX_PHONE_NUMBER = /\A\+?\d{0,3}(\s|-)?\(?\d{3}\)?(\s|-)?\d{3}(\s|-)?\d{4}\z/.freeze

  validates :email, presence: true, uniqueness: { message: I18n.t('activerecord.attributes.user.email.taken') }
  validates :gender, inclusion: { in: %w[m f o] }
  validates :phone_number, presence: true, format: { with: REGEX_PHONE_NUMBER }
  validates :password, presence: true, length: { minimum: 8, too_short: I18n.t('activerecord.errors.password_too_short') }

  validates_with EmailValidator
end
