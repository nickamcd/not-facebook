Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:index, :show]
  get 'users/:id' => 'users#show', via: :get
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  root to: "posts#index" 
end