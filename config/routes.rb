Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecasts, only: :index
      resources :backgrounds, only: :index
      resources :users, only: :create
    end
  end
end
