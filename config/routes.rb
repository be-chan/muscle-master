Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
  sessions: 'users/sessions' }
  root to: 'top#index'
  
  resources :users, only: [:show] do
    # resources :memos, except: [:show] 
  end
  resources :memos, except: [:show] do
    resources :tweets, only: [:new, :create]
  end
  resources :tweets, only: [:index, :show]
end
