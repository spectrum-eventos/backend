# frozen_string_literal: true

module V1
  class BaseController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Pundit

    devise_token_auth_group :member, contains: %i[admin worker client]
    before_action :authenticate_member!
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore

      render json: {
        errors: [I18n.t("#{policy_name}.#{exception.query}", scope: 'pundit', default: :default)]
      }, status: :forbidden
    end
  end
end
