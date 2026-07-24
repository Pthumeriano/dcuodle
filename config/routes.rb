Rails.application.routes.draw do
  devise_for :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Dados do jogo. A comparação acontece no front.
  get "characters", to: "characters#index", defaults: { format: :json }
  get "api/daily", to: "characters#daily", defaults: { format: :json }
  post "api/results", to: "results#create"

  get "stats", to: "stats#show"
  resources :character_requests, only: [ :index, :new, :create ]

  namespace :admin do
    root "dashboard#show"
    resources :users, only: [ :index, :show ]
    resources :character_requests, only: [ :index, :update ]
  end

  root "games#show"
end
