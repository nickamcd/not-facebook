Rails.application.routes.draw do
  devise_for :users

  get 'users/sign_out', to: 'devise/sessions#destroy'
  
  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :destroy] do
      collection do
        get 'accept'
        get 'deny'
      end
    end
  end
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  root to: 'posts#index'
end