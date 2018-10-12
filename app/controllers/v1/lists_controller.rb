# frozen_string_literal: true

module V1
  class ListsController < BaseController
    before_action :set_list, only: %w[show update destroy]

    def index
      authorize List
      search = List.search(params[:search])
      lists = search.result
      serializer = ListSerializer.new(lists)

      render json: serializer.serialize_with_pagination(params[:page]), status: :ok
    end

    def show
      authorize @list
      serializer = ListSerializer.new(@list)
      render json: serializer.serialize, status: :ok
    end

    def create
      authorize List
      @list = List.new(permitted_params)
      @list.save!
      serializer = ListSerializer.new(@list)
      render json: serializer.serialize, status: :created
    rescue ActiveRecord::RecordInvalid
      render json: { errors: @list.errors.full_messages }, status: :bad_request
    end

    def update
      authorize @list
      @list.update!(permitted_params)
      head :no_content
    end

    def destroy
      authorize @list
      @list.destroy
      head :no_content
    end

    private

    def permitted_params
      params.permit(:name, :event_id)
    end

    def set_list
      @list = List.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    alias pundit_user current_member
  end
end
