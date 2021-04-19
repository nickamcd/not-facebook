Rails.application.routes.draw do

  get 'friendships/create'
  get 'friendships/destroy'
  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  root to: "posts#index" 
end