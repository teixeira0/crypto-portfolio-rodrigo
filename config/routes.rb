Rails.application.routes.draw do
  get 'crypto_market/buy'
  post 'crypto_market/confirm'
  get 'crypto_market/confirm'
  get 'portfolio/view'
  post'portfolio/add_asset'

  resources :assets
  resources :bought_assets

  root 'portfolio#view'
end
