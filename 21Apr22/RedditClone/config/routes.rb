Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepage#index'

  resources :users, only: [:new, :create]
  resources :subs, except: [:destroy] do
    member do
      resources :posts, only: [:new]
    end
  end

  resources :posts, only: [:create, :show, :edit, :update, :destroy]
  
  resource :session, only: [:create, :new, :destroy]

end
