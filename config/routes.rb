Rails.application.routes.draw do
  get 'homes/about'
  devise_for :users
  
  root 'homes#top'
  
  resources :users, only: [:index, :show, :edit, :update] do
  end
  
  resources :posts
end
