# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  bio               :text
#  birthdate         :date
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
class UserSerializer < Panko::Serializer
  attributes :id, :email, :phone_number, :username, :gender, :role
end
