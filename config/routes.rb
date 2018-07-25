Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/bike-shop', to: 'accessories#index'
  get '/trips-dashboard', to: 'trips#dashboard'
  get '/stations-dashboard', to: 'stations#dashboard'
  resources :users, only: [:new, :create]
  resources :stations, only: [:show, :index, :create, :update, :destroy]
  resources :trips, only: [:show, :index, :create, :update, :destroy]
  resources :conditions, only: [:index, :show, :destroy]
  resources :dashboard, only: [:index]
  resources :accessories, only: [:show]
  resources :carts, only: [:create]
  namespace :admin do
    resources :stations, only: [:new, :edit]
    resources :trips, only: [:new, :edit]
    resources :conditions, only: [:new, :edit, :destroy]
  end
end
