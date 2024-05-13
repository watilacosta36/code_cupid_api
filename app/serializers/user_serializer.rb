# frozen_string_literal: true

class UserSerializer < Panko::Serializer
  attributes :id, :email, :phone_number, :username, :gender, :role
end
