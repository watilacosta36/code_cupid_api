# frozen_string_literal: true

if Rails.env.developmnet?
  require 'csv'
  require 'faker'

  # CREATE COUNTRIES
  path = 'db/country_code.csv'

  CSV.foreach(path) do |row|
    unless row[0].eql?('COUNTRY')
      CountryCode.create!(
        country: row[0],
        dialingcode: row[4]
      )
    end
  end

  # CREATE PLANS
  Plan.create!(duration_in_months: 12, name: 'Free', price: 0.0)
  Plan.create!(duration_in_months: 1, name: 'Monthly', price: 19.9)
  Plan.create!(duration_in_months: 6, name: 'Semi-Anually', price: 15.9)
  Plan.create!(duration_in_months: 12, name: 'Anually', price: 12.9)


  # CREATE USERS
  BATCH_SIZE = 1000

  (0...100_000).each_slice(BATCH_SIZE) do |batch|
    users = []

    batch.each do |t|
      users << {
        bio: Faker::Lorem.sentence(word_count: 3),
        age: Faker::Number.between(from: 18, to: 120),
        confirmation_code: SecureRandom.alphanumeric(4),
        confirmed_at: Date.today,
        email: Faker::Internet.email,
        password_digest: Faker::Internet.password(min_length: 8) ,
        gender: Faker::Gender.binary_type,
        username: Faker::Internet.username,
        phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
        created_at: DateTime.now,
        updated_at: DateTime.now,
        role: [:admin, :user].sample
      }
    end

    User.transaction do
      User.insert_all(users)
    end

    puts User.count
  end

  User.reindex
end
