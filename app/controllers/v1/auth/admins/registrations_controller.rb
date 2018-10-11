# frozen_string_literal: true

module V1
  module Auth
    module Admins
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        def account_update_params
          permittable_params = admin_attributes
          params.permit(permittable_params)
        end

        def account_permitted_params
          msg = 'errors.messages.validate_account_update_params'
          validate_post_data account_update_params, I18n.t(msg)
        end

        def admin_attributes
          %i[name password_confirmation password current_password]
        end

        protected

        def render_create_success
          resource_json = {
            id: @resource.id,
            provider: @resource.provider,
            email: @resource.email
          }

          render json: {
            success: true,
            admin: resource_data(resource_json: resource_json),
            info: I18n.t('devise.confirmations.send_instructions')
          }
        end

        def render_create_error_redirect_url_not_allowed
          error_key = 'devise_token_auth.registrations.redirect_url_not_allowed'
          render json: {
            status: 'error',
            admin:   resource_data,
            errors: [
              I18n.t(error_key, redirect_url: @redirect_url)
            ]
          }, status: :unprocessable_entity
        end

        def render_create_error
          render json: {
            status: 'error',
            admin:   resource_data,
            errors: resource_errors
          }, status: :unprocessable_entity
        end

        def render_update_success
          render json: {
            success: true,
            admin: AdminSerializer.new(@resource).show,
            info: I18n.t('devise.registrations.updated')
          }
        end

        def render_update_error
          render json: {
            status: 'error',
            errors: resource_errors
          }, status: :unprocessable_entity
        end

        def render_update_error_user_not_found
          render json: {
            status: 'error',
            errors: [I18n.t('devise_token_auth.registrations.user_not_found')]
          }, status: :not_found
        end

        private

        def resource_update_method
          if DeviseTokenAuth.check_current_password_before_update == :attributes
            'update_with_password'
          elsif DeviseTokenAuth.check_current_password_before_update == :password &&
                account_update_params.key?(:password)
            @resource.default_password_update_strategy
          elsif account_update_params.key?(:current_password)
            'update_with_password'
          else
            'update_attributes'
          end
        end
      end
    end
  end
end
