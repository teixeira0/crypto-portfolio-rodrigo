Rails.application.routes.draw do
  get 'portfolio/view'

  resources :assets

  root 'portfolio#view'
end
