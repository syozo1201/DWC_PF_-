Rails.application.routes.draw do
  get 'homes/about'
  devise_for :users
  
  root 'homes#top'
end
