Rails.application.routes.draw do
  root to: 'dashboard#show'
  get 'dashboard', to: 'dashboard#show'
  resources :users, only: [:new] do
    delete :destroy, on: :collection
  end
  get '/auth/instagram/callback', to: 'users#create'
end
