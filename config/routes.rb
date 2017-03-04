Rails.application.routes.draw do
  
  authenticated :user do
    root 'posts#index'
  end
  root 'static_pages#home'

  get 'static_pages/home'
  get '/friend_requests', to: 'users#friend_requests'
  get '/notifications', to: 'static_pages#notifications'

  devise_for :users, :controllers => 
                     { :omniauth_callbacks => "users/omniauth_callbacks" }
    # devise_scope :user do
    #   delete 'sign_out', :to => 'devise/sessions#destroy', 
    #                      :as => :destroy_user_session
    # end

  resources :users, only: [:show, :index]
  resources :friendships, only: [:create, :update, :destroy, :index]
  resources :posts do
	  resources :comments, only: [:create, :destroy]
	  resources :likes, only: [:create, :destroy]
	end

end
