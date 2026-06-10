Rails.application.routes.draw do
  mount_avo
  namespace :api do
    namespace :v1 do
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

      get "health", to: "health#index"

      resources :tenants, only: [:index, :show, :create, :update]
      resources :users, only: [:index, :show, :update, :destroy]
    end
  end
end