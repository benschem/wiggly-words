Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/signup", to: "users#new", as: :signup
  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout
  resources :users, only: [ :index, :show, :create, :destroy ], param: :username do
    resources :games, only: [ :index, :show, :create ]
  end
  resources :words, only: [ :index, :create ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
