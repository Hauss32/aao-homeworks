Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :users, only: [:create, :new]

  resources :bands do
    resources :albums, only: [:new, :index]
  end

  resource :session, only: [:create, :new, :destroy]

  resources :home, only: [:index]

  resources :albums, only: [:index, :destroy, :show, :edit, :create, :update] do
    resources :tracks, only: [:new, :index]
  end

  resources :tracks, only: [:create, :index, :edit, :show, :update, :destroy]
end
