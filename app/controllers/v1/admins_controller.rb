# frozen_string_literal: true

module V1
  class AdminsController < BaseController
    before_action :set_admin, only: %w[show update destroy]

    def index
      authorize Admin
      admins = Admin.order(:created_at)
      serializer = AdminSerializer.new(admins)

      render json: serializer.serialize_with_pagination(params[:page]), status: :ok
    end

    def show
      authorize @admin
      serializer = AdminSerializer.new(@admin)
      render json: serializer.serialize, status: :ok
    end

    def create
      authorize Admin
      @admin = Admin.new(permitted_params)
      @admin.save!
      serializer = AdminSerializer.new(@admin)
      render json: serializer.serialize, status: :created
    rescue ActiveRecord::RecordInvalid
      render json: { errors: @admin.errors.full_messages }, status: :bad_request
    end

    def update
      authorize @admin
      @admin.update!(permitted_params)
      head :no_content
    end

    def destroy
      authorize @admin
      @admin.destroy
      head :no_content
    end

    private

    def permitted_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def set_admin
      @admin = Admin.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    alias pundit_user current_member
  end
end
