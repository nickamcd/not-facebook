Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :destroy]
  end
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  root to: "posts#index" 
end