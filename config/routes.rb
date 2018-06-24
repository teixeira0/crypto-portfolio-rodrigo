Rails.application.routes.draw do
  get 'crypto_market/buy'
  get 'portfolio/view'

  resources :assets
  resources :bought_assets

  root 'portfolio#view'
end
