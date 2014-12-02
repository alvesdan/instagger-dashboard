Rails.application.routes.draw do
  root to: 'dashboard#show'
  get 'dashboard', to: 'dashboard#show'
  resources :users, only: [:new]
  get '/auth/instagram/callback', to: 'users#create'
end
