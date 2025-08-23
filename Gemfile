source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap'
gem 'chartjs-ror'
gem 'coffee-rails'
gem 'devise'
gem 'devise-i18n'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'letter_opener', group: :development
gem 'money-rails'
# gem 'pg'  # Commented out for SQLite development
gem 'sqlite3', '~> 2.7'
gem 'puma'
gem 'rails', '~> 8.0.2'
gem 'rails-i18n'
gem 'rolify'
gem 'sass-rails'
gem 'slim'
gem 'steel_wheel', path: '/Users/horizon/steel_wheel' # ~> 0.6'
gem 'easy_form', path: '/Users/horizon/easy_form' # ~> 0.6'
gem 'timecop'
gem 'toritori'
gem 'turbolinks'
gem 'uglifier'
gem 'unitwise'
gem 'values'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-rails'
end
gem 'i18n'
group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'routes_graph', path: '/Users/horizon/routes_graph'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
