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
  has_secure_password

  validates_with EmailValidator
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 8 }
  validates :gender, inclusion: { in: %w[m f o] }
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\+?[0-9]{10,15}\z/ }
end
