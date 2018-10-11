# frozen_string_literal: true

module Rack
  class Attack
    throttle('req/ip', limit: 300, period: 5.minutes) do |req|
      req.ip unless req.path.start_with?('/assets')
    end

    throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
      req.ip if (req.path == '/admin' && req.get?) || (req.path == '/docs' && req.get?)
    end

    blocklist('block ncsi requests') do |req|
      req.path.match('/ncsi')
    end
  end
end

Rails.application.config.middleware.use Rack::Attack
