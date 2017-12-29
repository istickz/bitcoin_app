Rails.application.routes.draw do
  root 'wallets#index'
  resources :txes, only: [:index, :show]
  resources :blocks, only: [:index, :show]
  resources :wallets, only: [:index, :show]
end
