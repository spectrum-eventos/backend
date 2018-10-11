# frozen_string_literal: true

Rack::Timeout.timeout = 15 if ENV['RAILS_ENV'] == 'production'
