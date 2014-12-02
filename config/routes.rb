Rails.application.routes.draw do
  root to: 'dashboard#index'
  resources :users, only: [:new]
  get '/auth/instagram/callback', to: 'users#create'
end
