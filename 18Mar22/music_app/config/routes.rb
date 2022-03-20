Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :users, only: [:create, :new]
  resources :bands
  resource :session, only: [:create, :new, :destroy]

  resources :home, only: [:index]
end
