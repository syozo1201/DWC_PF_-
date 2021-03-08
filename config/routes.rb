Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'homes/about'
  devise_for :users
  
  root 'homes#top'
  
  resources :users, only: [:index, :show, :edit, :update] do
  end
end
