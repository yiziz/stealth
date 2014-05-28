source 'https://rubygems.org'

platform :jruby do
  # Use postgresql as the database for Active Record
  gem 'activerecord-jdbcpostgresql-adapter', '1.3.7'
end

platform :ruby do 
  # Use postgresql as the database for Active Record
  gem 'pg', '0.17.1'
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '3.1.0'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '2.2.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', '1.1.3',       group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano-rails', '1.1.1', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# self added

gem 'active_model_serializers', '0.8.1'

gem 'pundit', '0.2.3'

group :development do
  gem 'meta_request', '0.3.0'
end

group :development, :test do
  gem 'factory_girl_rails', '4.4.1'
  gem 'fuubar', '1.3.3'
  gem 'guard-rspec', '4.2.9'
  gem 'guard-spork', '1.5.1'
  gem 'guard-zeus', '2.0.0'
  gem 'parallel_tests', '0.16.10'
  gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i
  gem 'rspec-rails', '2.14.2'
  gem 'spork-rails', '4.0.0'
  gem 'zeus', '0.15.1'
  #gem 'zeus-parallel_tests', '0.2.5'#, git: 'https://github.com/yz0075/zeus-parallel_tests.git'
end
