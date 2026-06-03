module Api
  module V1
    class BaseController < ApplicationController
      include Pundit::Authorization

      before_action :authenticate_user!

      rescue_from Pundit::NotAuthorizedError, with: :forbidden
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable

      private

      def forbidden
        render json: { error: "No autorizado" }, status: :forbidden
      end

      def not_found
        render json: { error: "Recurso no encontrado" }, status: :not_found
      end

      def unprocessable(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end