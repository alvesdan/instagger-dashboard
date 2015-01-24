Rails.application.routes.draw do
  root to: 'dashboard#show'
  get 'dashboard', to: 'dashboard#show'
  resources :users, only: [:new]
  get '/sign-out', to: 'users#destroy'
  get '/auth/instagram/callback', to: 'users#create'
end
