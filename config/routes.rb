Rails.application.routes.draw do

  root to: 'homepage#index'
  get 'auth/:provider/callback', to: 'sessions#create'

  resources :homepage, only: [:index]
  resources :dashboard, only: [:index]
  resources :users
  resources :user_followees, except: [:edit, :update, :new]
  resources :suggested_followees, only: [:index]
  resources :books, only: [:index]
  resources :sessions, only: [:create]

  get '/login',  to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :book_search_results, only: [:index]

  post '/add-book', to: 'book_on_shelf#create'

  resources :book_comparisons, only: [:show]

end
