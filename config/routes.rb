Rails.application.routes.draw do
  resources :txes, only: [:index, :show]
  resources :blocks, only: [:index, :show]
end
