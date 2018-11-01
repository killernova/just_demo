Rails.application.routes.draw do
  get 'users/create'

  root 'articles#index'
  resources :sessions, only: [:create, :destroy]
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  resources :articles
  resources :users, only: [:create]
end
