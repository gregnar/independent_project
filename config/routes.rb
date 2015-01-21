Rails.application.routes.draw do

  root to: 'homepage#index'
  get 'auth/:provider/callback', to: 'sessions#create'

  resources :homepage, only: [:index]
  resources :dashboard, only: [:index]
  resources :users

  resources :sessions, only: [:create]
  get '/login',  to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :book_search_results, only: [:index]


end
