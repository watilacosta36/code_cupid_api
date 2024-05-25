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
require "test_helper"

class CountryCodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
