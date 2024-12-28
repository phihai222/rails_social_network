Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  namespace :api do
    namespace :v1 do
      resources :auth, only: [] do
        collection do
          post :registration
          post :login
          post :validate_otp
        end
      end
      resources :ping, only: [:index] do
        collection do
          post :test_post
        end
      end
      resources :users, only: [] do
        collection do
          get :me
          patch "me", to: "users#update_me"
        end
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
