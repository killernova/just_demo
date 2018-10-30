Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [:create]
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  resources :articles
  resources :users, only: [:create]
end
