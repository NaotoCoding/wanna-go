Rails.application.routes.draw do
  devise_for :users
  root 'belonging_groups#index'

  resources :groups, only: [:show, :new, :create] do
    resources :invites, only: [:new, :create]
  end
end
