Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  root to: 'visitors#index'
  devise_for :users
  resources :users
end