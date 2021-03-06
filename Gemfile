# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.7.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 6.1.3", ">= 6.1.3.2"
# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"
# Use Puma as the app server
gem "puma", "~> 5.0"
# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1.7"
gem "jwt"

gem "cancancan", "~>3.2.1"

#model serializer
gem 'active_model_serializers', '~> 0.10.0'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  # Shim to load environment variables from .env into ENV in development.
  gem "dotenv-rails", groups: %i[development test]
  # Testing framework
  gem "factory_bot_rails", "~> 6.2.0"
  gem "ffaker", "~> 2.18.0"
  gem "rspec-rails", "~> 5.0.0"
end

group :development do
  gem "listen", "~> 3.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
