# frozen_string_literal: true

# == Schema Information
#
# Table name: country_codes
#
#  id          :bigint           not null, primary key
#  country     :string
#  dialingcode :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class CountryCode < ApplicationRecord
  validates :country, :dialingcode, presence: true
end
