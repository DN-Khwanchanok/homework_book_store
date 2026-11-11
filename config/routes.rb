Rails.application.routes.draw do
  root "books#index"
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  # 
  resources :books, only: [:index, :show]
  get "admin", to: "admin#index", as: :admin

  namespace :api, defaults: { format: :json } do
    resources :books, only: [:index, :show]
    resources :categories, only: [:index, :show]
    resources :markets, only: [:index, :show]
    resources :users, only: [:index, :show]
  end

  namespace :admin do
    resources :books, only: [:new, :create, :edit, :update, :destroy]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :users, only: [:new, :create]
    resources :markets, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
