Rails.application.routes.draw do
  devise_for :users
  root 'belonging_groups#index'

  resources :invites, only: [:index]

  resources :groups, only: [:show, :new, :create] do
    resources :invites, only: [:new, :create] do
      resources :accepted_invites, only: [:create]
      resources :rejected_invites, only: [:create]
    end

    resources :places, only: [:new, :create]
  end
end
