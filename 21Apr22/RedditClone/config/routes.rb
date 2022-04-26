Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepage#index'

  resources :users, only: [:new, :create]

  resources :subs, except: [:destroy]

  resources :posts, except: [:index] do
    member do 
      resources :comments, only: [:new]
    end
  end

  resources :comments, only: [:create]

  resource :session, only: [:create, :new, :destroy]

end
