Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auth, only: [] do
        collection do
          post :registration
          post :login
        end
      end
      resources :ping, only: [:index] do
        collection do
          post :test_post
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
