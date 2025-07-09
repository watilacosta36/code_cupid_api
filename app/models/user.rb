# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  bio               :text
#  age               :integer
#  confirmation_code :string
#  confirmed_at      :datetime
#  email             :string
#  gender            :string
#  locale            :string
#  password_digest   :string
#  phone_number      :string
#  role              :integer
#  username          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # ASSOCIATIONS
  has_many_attached :images
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :matched_users, through: :matches
  has_one :subscription, dependent: :destroy
  has_one :plan, through: :subscription

  # OTHERS
  REGEX_PHONE_NUMBER = /\A\+?\d{0,3}(\s|-)?\(?\d{3}\)?(\s|-)?\d{3}(\s|-)?\d{4}\z/

  has_secure_password validations: false

  searchkick

  # VALIDATIONS
  validates :gender, inclusion: { in: %w[male female] }, on: :update
  validates :phone_number, presence: true, format: { with: REGEX_PHONE_NUMBER }
  validates :email, presence: true, uniqueness: { message: I18n.t('activerecord.attributes.user.email.taken') }
  validates :password, presence: true,
                       length: { minimum: 8, too_short: I18n.t('activerecord.errors.password_too_short') }, on: :create

  validates_with EmailValidator

  # ENUMS
  enum :role, { user: 0, admin: 1 }
  enum :gender, { male: 0, female: 1 }
  enum :status, { active: 0, inactive: 1 }

  before_validation :default_role
  after_commit :apply_free_plan_subscription

  def search_data
    {
      status: status,
      age: age,
      gender: gender
    }
  end

  def update_confirmation_status(confirmation_code)
    return unless self.confirmation_code.eql?(confirmation_code)

    update_attribute(:confirmed_at, Time.zone.now)
  end

  private

  def default_role
    return if role.present?

    self.role = :user
  end

  def apply_free_plan_subscription
    return unless subscription.nil?

    free_plan = Plan.find_by(price: 0.0)

    Subscription.create!(
      start_date: DateTime.now,
      end_date: Time.now.advance(months: free_plan.duration_in_months),
      user_id: id,
      plan_id: free_plan.id
    )
  end
end
