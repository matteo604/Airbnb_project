Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Root path for the application (homepage)
  root to: "properties#index"

  # Nested routes for properties and bookings
  resources :properties do
    resources :bookings, only: [:new, :create]  # Bookings can be created under properties
    collection do
      get :search  # Adding search route for properties
      get :suggestions  # Route for AJAX suggestions
    end
  end

  # nnested routes for bookings and reviews
  resources :bookings do
    resources :reviews, only: [:create, :destroy]  # Reviews can be created or deleted under bookings
  end
end
