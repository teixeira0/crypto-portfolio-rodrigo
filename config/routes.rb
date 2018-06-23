Rails.application.routes.draw do
  get 'portfolio/view'

  root 'portfolio#view'
end
