source 'https://rubygems.org'

# Sinatra for sidekiq web view
gem 'sinatra'
# Ruby binding for CURL
gem 'curb'
# Sidekiq
gem 'sidekiq'
# Dotenv
gem 'dotenv-rails'
# Redis for persist ETAG
gem 'redis', '~>3.2'
# Cron abstraction
gem 'whenever'
# Suggested gem for pacing meta infromation
gem 'treetop-dcf'
# PostgreSQL Adapter
gem 'pg'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Database cleaner
gem 'database_cleaner'
# Use Puma as the app server
gem 'puma'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
end

group :test do
  gem 'webmock'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

