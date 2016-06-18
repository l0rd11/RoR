Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  root to: 'visitors#index'
  # get '/facebook/new_comment', to: 'facebook#new_comment'
  # post '/facebook/comment', to: 'facebook#comment'
  devise_for :users
  resources :users
  resources :tweets
  resources :facebook
  resources :news
  get '/oauth/redirect', to: 'oauth#redirect'


end