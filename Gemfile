# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'

# database
gem 'pg'

# caching
gem 'msgpack'
gem 'redis-rails', '~> 5'

# server
gem 'dotenv-rails'
gem 'puma', '~> 3.7'
gem 'rack-attack'
gem 'rack-canonical-host'
gem 'rack-cors'

# validations
gem 'cpf_cnpj'

# aws
gem 'aws-sdk', '~> 3'

# jobs
gem 'sidekiq'

# controllers
gem 'ransack', github: 'activerecord-hackery/ransack'

# authentication
gem 'devise_token_auth'
gem 'omniauth-facebook'

# authorization
gem 'pundit'

# views
gem 'kaminari'
gem 'oj'
gem 'slim'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'

  # performance and metrics
  gem 'brakeman',  require:  false
  gem 'rubocop',   require:  false
  gem 'simplecov', require:  false
  gem 'stackprof'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'aws-ses', '~> 0.6.0', require: 'aws/ses'
  gem 'rack-timeout', '~> 0.3.2'
end
