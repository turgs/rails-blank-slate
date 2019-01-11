Rails.application.routes.draw do
  get  'register',  to: 'accounts#new',     as: 'register'
  post 'register',  to: 'accounts#create'
  get  'login',     to: 'sessions#new',     as: 'login'
  get  'logout',    to: 'sessions#destroy', as: 'logout'

  # root to: 'appointments#index'

  resources :accounts
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:create]
  resources :users
end
