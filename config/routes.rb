Rails.application.routes.draw do
  
  authenticated :user do
    root 'posts#index'
  end
  root 'static_pages#home'

  get 'static_pages/home'
  get '/friend_requests', to: 'users#friend_requests'
  get '/notifications', to: 'static_pages#notifications'
  get '/friends', to: 'users#friends'

  devise_for :users, :controllers => 
                     { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show, :index, :friends]
  resources :friendships, only: [:create, :update, :destroy]
  resources :posts do
	  resources :comments, only: [:create, :destroy]
	  resources :likes, only: [:create, :destroy]
	end

end
