source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.3"
gem "puma", "~> 5.0"
gem "sprockets-rails"

#
gem "ffi"
 
# Image processing
gem "image_processing", ">= 1.2"

# Database driver
gem "pg", "~> 1.1"
gem 'pg_search'

gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data"
gem "bootsnap", require: false

# Styling
gem "tailwindcss-rails", "~> 2.0"

# PDF reports
gem 'wicked_pdf' 
gem 'wkhtmltopdf-binary'
gem 'wkhtmltopdf-heroku'

# Authentication
gem 'devise', '~> 4.8', '>= 4.8.1'

# Authorization
gem 'cancancan'

# Omniauth
gem 'omniauth'
gem "omniauth-rails_csrf_protection"
gem 'omniauth-github'
gem 'omniauth-google-oauth2'

# Hosting
gem 'cloudinary'

gem 'i18n', '~> 1.12'

# Load env variables
gem 'dotenv-rails', groups: [:development, :test]

gem 'rubocop-rails', require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
end

group :development do
  gem "web-console"
  gem 'annotate', '~> 3.1', '>= 3.1.1'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
