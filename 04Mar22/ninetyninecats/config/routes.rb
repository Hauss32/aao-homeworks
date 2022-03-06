Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cats#index'
  resources :cats
  resources :rental_requests, only: [:new, :create]
end
