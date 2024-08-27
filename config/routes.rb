Rails.application.routes.draw do
  get "categories/new"
  get "categories/create"
  get "expenses/index"
  get "expenses/show"
  get "expenses/new"
  get "expenses/edit"
  # Route for login and logout
  root 'sessions#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  resources :expenses
  resources :categories, only: [:new, :create]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
