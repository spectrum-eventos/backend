# frozen_string_literal: true

module V1
  module Auth
    module Admins
      class PasswordsController < ::DeviseTokenAuth::PasswordsController
        def edit
          super do |resource|
            resource.update(password_will_change: true)
          end
        end

        def update
          super do |resource|
            resource.update(password_will_change: false)
          end
        end

        protected

        def resource_update_method
          update_attributes? ? 'update_attributes' : 'update_with_password'
        end

        private

        def update_attributes?
          DeviseTokenAuth.check_current_password_before_update == false ||
            @resource.password_will_change
        end
      end
    end
  end
end
