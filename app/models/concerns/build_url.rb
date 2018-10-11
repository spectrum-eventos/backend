# frozen_string_literal: true

module Concerns
  module BuildUrl
    extend ActiveSupport::Concern

    def build_auth_url(base_url, args)
      args[:uid]    = uid
      args[:expiry] = tokens[args[:client_id]]['expiry']

      "#{base_url}?#{args.to_query}"
    end
  end
end
