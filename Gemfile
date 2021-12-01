# frozen_string_literal: true

source('https://rubygems.org')
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
# ruby
ruby('2.6.5')
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem('rails', '~> 5.2.4', '>= 5.2.4.2')
# Use sqlite3 as the database for Active Record
gem('sqlite3')
# Use Puma as the app server
gem 'puma', '< 6'
# Use SCSS for stylesheets
gem('sass-rails', '~> 5.0')
# Use Uglifier as compressor for JavaScript assets
gem('uglifier', '>= 1.3.0')
# Use tinymce-rails for editing the events page
gem 'tinymce-rails'
# Use CoffeeScript for .coffee assets and views
gem('coffee-rails', '~> 4.2')
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem('turbolinks', '~> 5')
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem('jbuilder', '~> 2.5')

gem('mail_form')

gem 'sprockets-rails', '~> 3.2', '>= 3.2.2'

gem 'font-awesome-sass', '~> 4.7.0'

gem 'bootstrap-icons', '~> 1.0', '>= 1.0.8'

gem 'brakeman', '~> 5.1', '>= 5.1.1'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem('bootsnap', '>= 1.1.0', require: false)
gem 'bootstrap'
gem 'devise'
gem('dotenv-rails', require: 'dotenv/rails-now')
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pagy'

group :development, :test do
  gem 'bundler-audit'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8'
  # Use rails-controller-testing for testing a controller
  gem 'rails-controller-testing'
  # Use rubocop for static code analysis
  gem 'rubocop', '~> 0.81.0', require: false
  # Use coveralls for code-coverage
  gem 'coveralls', require: false
  # Use simplecov to generate the coveralls report in .html format
  gem 'figaro'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'capistrano', '3.11.2'
  gem 'capistrano-bundler', '~> 1.6', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rvm', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  # Mysql database.
  gem 'mysql2'
  # Needed to get console working in production mode
  gem 'rb-readline'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem('tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby])
