Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :create, :show, :update, :destroy] do
    resources :artworks, :comments, :likes, only: [:index]
  end

  resources :artworks, only: [:create, :show, :update, :destroy] do
    resources :comments, :likes, only: [:index]
    post :like, to: 'artworks#like', as: 'like'
    post :unlike, to: 'artworks#unlike', as: 'unlike'
  end

  resources :artwork_shares, only: [:create, :destroy]

  resources :comments, only: [:index, :create, :destroy] do
    resources :likes, only: [:index]
    post :like, to: 'comments#like', as: 'like'
    post :unlike, to: 'comments#unlike', as: 'unlike'
  end
end
