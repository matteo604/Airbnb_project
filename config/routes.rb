Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # health check for route
  get "up" => "rails/health#show", as: :rails_health_check

  # routes for properties
  resources :properties, only: [:index, :new, :create] do
    # nested routes for bookings under properties
    resources :bookings, only: [:new, :create] do
      # nnested routes for reviews under bookings, started just with create and destroy
      resources :reviews, only: [:create, :destroy]
    end
  end
end
