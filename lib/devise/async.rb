# frozen_string_literal: true

module Devise
  module Async
    def self.included(base)
      base.class_eval do
        def send_devise_notification(notification, *args)
          devise_mailer.delay.send(notification, { id: id, class_name: self.class.name }, *args)
        end
      end
    end
  end
end
