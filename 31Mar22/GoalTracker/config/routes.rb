Rails.application.routes.draw do
  root to: 'home#index'

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]

  resources :goals
end
