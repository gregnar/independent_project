Rails.application.routes.draw do

  root to: 'homepage#index'
  get 'auth/:provider/callback', to: 'sessions#create'

  resources :homepage, only: [:index]
  resources :dashboard, only: [:index]
  resources :users
  resources :sessions
  resources :book_search_results, only: [:index]

  get '/auth/:provider/callback', to: 'sessions#create'

end
