Rails.application.routes.draw do
  devise_for :users

  get 'users/sign_out', to: 'devise/sessions#destroy'
  get 'friendships/', to: 'users#index', as: 'friendship'
  
  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :destroy] do
      collection do
        get :accept
        get :deny
      end
    end
  end

  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :notifications, only: [:index] do
    collection do
      post :mark_as_read
    end
  end

  root to: 'posts#index'
end