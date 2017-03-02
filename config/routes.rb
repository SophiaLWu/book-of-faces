Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/home'
  get '/friend_requests', to: 'users#friend_requests'
  get '/notifications', to: 'static_pages#notifications'

  devise_for :users
  resources :friendships, only: [:create, :update, :destroy]
  resources :posts
  resources :comments, only: [:new, :create, :destroy]
end
