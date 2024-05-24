# Create country codes
#
require 'csv'

path = 'db/country_code.csv'

CSV.foreach(path) do |row|
  unless row[0].eql?('COUNTRY')
    CountryCode.create!(
      country: row[0],
      dialingcode: row[4]
    )
  end
end