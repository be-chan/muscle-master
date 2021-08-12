Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
  sessions: 'users/sessions' }
  root to: 'top#index'
  
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :memos, except: [:show] do
    resources :tweets, only: [:new, :create, :destroy]
  end

  resources :tweets, only: [:index, :show] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
