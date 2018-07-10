require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post "logout" => "sessions#destroy", as: "logout"
  get "login" => "sessions#new", as: "login"
  # resources :sessions
  resource :sessions, only: [:create, :destroy]
  resources :password_resets

  resources :users do
    member do
      post 'reset_password'
    end
  end

  get "welcome" => "welcome#show", as: "welcome"

  root to: "sessions#new"

end
