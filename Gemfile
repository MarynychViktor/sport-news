source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
# Use sqlite3 as the database for Active Record
gem 'pg', '~> 1.2'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'inline_svg'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'carrierwave', '~> 2.0'
gem 'carrierwave-base64', '~> 2.10'
gem 'devise', '~> 4.8'
gem 'elasticsearch-model', '~> 7.1', '>= 7.1.1'
gem 'elasticsearch-rails', '~> 7.1', '>= 7.1.1'
gem 'friendly_id', '~> 5.4.0'
gem 'kaminari', '~> 0.16.3'
gem 'ranked-model', '~> 0.4.0'
gem 'rolify', '~> 6.0'
gem 'simple_form', '~> 5.0'
gem 'slim', '~> 4.1.0'
gem 'view_component', require: 'view_component/engine'
gem 'sidekiq', '~> 4.1', '>= 4.1.2'
gem 'pundit', '~> 1.1'
# Latest stable version has error with Google::Apis::StorageV1::StorageService#copy_object
gem 'fog-google', git: 'git://github.com/fog/fog-google', branch: "master"
# Enabled faked and factory_bot_rails in production to seed demo with fake data
# TODO: move to test group
gem 'factory_bot_rails'
gem 'faker'
# Add possibility for quick login on production demo
# TODO: move to development group
gem 'any_login'
gem 'omniauth-google-oauth2', '~> 1.0'
gem 'omniauth', '~> 2.0'
gem 'omniauth-rails_csrf_protection'
gem 'mobility', '~> 1.1.2'
gem 'redis-store', '~> 1.1', '>= 1.1.7'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'annotate', '~> 3.1', '>= 3.1.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'pry-rails'
  gem 'spring'
  gem 'nokogiri'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'cucumber-rails', require: false
  gem 'webdrivers'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'database_cleaner-active_record'
  gem 'rails-controller-testing'
  gem 'rspec-its'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
