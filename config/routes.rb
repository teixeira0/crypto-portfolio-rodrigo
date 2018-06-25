Rails.application.routes.draw do
  get 'crypto_market/buy'
  post 'crypto_market/confirm'
  get 'crypto_market/confirm'
  get 'crypto_market/refresh'
  get 'crypto_market/update_quantity'
  get 'portfolio/view'
  get 'portfolio/reset'
  post'portfolio/add_asset'

  resources :assets
  resources :bought_assets

  root 'portfolio#view'
end
