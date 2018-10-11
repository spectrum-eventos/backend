# frozen_string_literal: true

module V1
  class PresencesController < BaseController
    before_action :set_presence, only: %w[show update destroy]

    def index
      authorize Presence
      presences = Presence.order(:created_at)
      serializer = PresenceSerializer.new(presences)

      render json: serializer.serialize_with_pagination(params[:page]), status: :ok
    end

    def show
      authorize @presence
      serializer = PresenceSerializer.new(@presence)
      render json: serializer.serialize, status: :ok
    end

    def create
      authorize Presence
      @presence = Presence.new(permitted_params)
      @presence.save!
      serializer = PresenceSerializer.new(@presence)
      render json: serializer.serialize, status: :created
    rescue ActiveRecord::RecordInvalid
      render json: { errors: @presence.errors.full_messages }, status: :bad_request
    end

    def update
      authorize @presence
      @presence.update!(permitted_params)
      head :no_content
    end

    def destroy
      authorize @presence
      @presence.destroy
      head :no_content
    end

    private

    def permitted_params
      params.permit(:name, :date, :list_id)
    end

    def set_presence
      @presence = Presence.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    alias pundit_user current_member
  end
end
