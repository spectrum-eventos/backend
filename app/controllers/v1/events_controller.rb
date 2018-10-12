# frozen_string_literal: true

module V1
  class EventsController < BaseController
    before_action :set_event, only: %w[show update destroy]

    def index
      authorize Event
      search = Event.search(params[:search])
      events = search.result
      serializer = EventSerializer.new(events)

      render json: serializer.serialize_with_pagination(params[:page]), status: :ok
    end

    def show
      authorize @event
      serializer = EventSerializer.new(@event)
      render json: serializer.serialize, status: :ok
    end

    def create
      authorize Event
      @event = Event.new(permitted_params)
      @event.save!
      serializer = EventSerializer.new(@event)
      render json: serializer.serialize, status: :created
    rescue ActiveRecord::RecordInvalid
      render json: { errors: @event.errors.full_messages }, status: :bad_request
    end

    def update
      authorize @event
      @event.update!(permitted_params)
      head :no_content
    end

    def destroy
      authorize @event
      @event.destroy
      head :no_content
    end

    private

    def permitted_params
      params.permit(:name)
    end

    def set_event
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    alias pundit_user current_member
  end
end
