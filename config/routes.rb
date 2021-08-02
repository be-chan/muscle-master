Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
  sessions: 'users/sessions' }
  root to: 'top#index'
  
  resources :users, only: [:show] 

  resources :memos, except: [:show] do
    resources :tweets, only: [:new, :create]
  end

  resources :tweets, only: [:index, :show] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
