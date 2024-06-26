# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.3'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'image_processing', '~> 1.2'
gem 'interactor', '~> 3.0'
gem 'interactor-rails', '~> 2.0'
gem 'jwt'
gem 'searchkick'
gem 'opensearch-ruby'
gem 'pagy', '~> 8.4'
gem "panko_serializer"
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'pundit'
gem 'rack-cors'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'rails-i18n', '~> 7.0.0'
gem 'rubocop', require: false
gem "solid_queue"
gem 'twilio-ruby', '~> 7.0.2'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'ruby-vips', '~> 2.2', '>= 2.2.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  gem 'pry-rails'
  gem 'faker'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'annotate' # Annotate Rails classes with schema information
  gem 'awesome_print'
  gem 'bullet'
end
