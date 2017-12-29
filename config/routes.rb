Rails.application.routes.draw do
  resources :txes, only: [:index, :show]
  resources :blocks, only: [:index, :show]
  resources :wallets, only: [:index, :show]
end
