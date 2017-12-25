Rails.application.routes.draw do
  resources :txes, only: [:index, :show]
  resources :blocks, only: [:index, :show]
  resources :tx_ins, only: [:index, :show]
  resources :tx_outs, only: [:index, :show]
end
