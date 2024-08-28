Rails.application.routes.draw do
  root "sessions#new"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  post "logout", to: "sessions#destroy"

  resources :expenses do
    patch :update_budget, on: :collection
    member do
      get "confirm_delete"
    end
  end

  resources :categories, only: [ :new, :create ]

  get "budgets/edit/:month/:year", to: "budgets#edit", as: "edit_budget"
  patch "budgets/update/:month/:year", to: "budgets#update", as: "update_budget"
  get "change_month", to: "budgets#change_month", as: "change_month"
  post "update_month", to: "budgets#update_month", as: "update_month"

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
