Rails.application.routes.draw do
  # Rutas de sesión para Avo (panel admin)
  root to: "hub#index"
devise_for :users,
  path: "admin",
  path_names: {
    sign_in: "login",
    sign_out: "logout"
  },
  controllers: {
    sessions: "admin/sessions"
  },
  skip: [:registrations, :passwords, :confirmations]

  namespace :api do
    namespace :v1 do
      # Auth API para React
      devise_for :users,
        path: "auth",
        path_names: {
          sign_in: "sign_in",
          sign_out: "sign_out",
          registration: "sign_up"
        },
        controllers: {
          sessions: "api/v1/auth/sessions",
          registrations: "api/v1/auth/registrations"
        }

      # Health check
      get "health", to: "health#index"

      # Tenants
      resources :tenants, only: [:index, :show, :create, :update]

      # Users
      resources :users, only: [:index, :show, :update, :destroy]
    end
  end

  # Avo
  mount_avo
end