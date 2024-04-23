source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem 'rails-i18n', '~> 7.0.0'
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
# gem "jbuilder" # Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "redis", ">= 4.0.1" # Use Redis adapter to run Action Cable in production
# gem "kredis" # Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
gem "bcrypt", "~> 3.1.7" # Use Active Model has_secure_password
gem "tzinfo-data", platforms: %i[ windows jruby ] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb
gem "image_processing", "~> 1.2" # Use Active Storage variants
gem "rack-cors" # Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'annotate' # Annotate Rails classes with schema information
end

