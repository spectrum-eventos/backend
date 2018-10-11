# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  if !Rails.application.config.consider_all_requests_local || ENV['FORCE_NOTIFY']
    rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError do |exception|
      render_not_found(exception)
    end

    rescue_from Exception do |exception|
      render_internal_error(exception)
    end
  end

  def raise_not_found!
    raise ActionController::RoutingError, params[:unmatched_route]
  end

  private

  def render_not_found
    render json: { error: 'Resource Not Found', status: 404 }, status: :not_found
  end

  def render_internal_error
    render json: { error: 'Internal Server Error', status: 500 }, status: :internal_server_error
  end
end
