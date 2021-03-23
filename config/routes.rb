Rails.application.routes.draw do
  get 'homes/about'
  devise_for :users, controllers: {
   omniauth_callbacks: 'users/omniauth_callbacks',
   registrations: 'users/registrations'
 }

  root 'homes#top'

  resources :users, only: [:index, :show, :edit, :update] do
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy, :index]
    resources :post_comments, only: [:create, :destroy]
  end

  get 'post/ranking' => 'posts#rank'
  get 'post/random' => 'posts#random'
end
