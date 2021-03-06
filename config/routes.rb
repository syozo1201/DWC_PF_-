Rails.application.routes.draw do
  get 'homes/about'
  devise_for :users, controllers: {
   omniauth_callbacks: 'users/omniauth_callbacks',
   registrations: 'users/registrations'
 }

  root 'homes#top'
  get '/search' => 'searchs#search'

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy, :index]
    resources :post_comments, only: [:create, :destroy, :show]
  end

  get 'post/ranking' => 'posts#rank'
  get 'post/random' => 'posts#random'
end
