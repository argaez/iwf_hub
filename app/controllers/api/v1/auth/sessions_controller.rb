module Api
  module V1
    module Auth
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          render json: {
            message: "Sesión iniciada correctamente",
            user: {
              id: resource.id,
              name: resource.name,
              email: resource.email,
              role: resource.role
            }
          }, status: :ok
        end

        def respond_to_on_destroy
          render json: { message: "Sesión cerrada correctamente" }, status: :ok
        end
      end
    end
  end
end