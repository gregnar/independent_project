Rails.application.routes.draw do

  root to: 'homepage#index'

  resources :homepage, only: [:index]
  resources :dashboard, only: [:index]
  resources :users
  resources :sessions

  get '/auth/:provider/callback', to: 'sessions#create'

end
