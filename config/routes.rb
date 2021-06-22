Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
  sessions: 'users/sessions' }
  root to: 'top#index'
  
  resources :users, only: [:show] do
    resources :memos, except: [:show]
  end
end
