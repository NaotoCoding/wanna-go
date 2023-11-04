Rails.application.routes.draw do
  devise_for :users
  root 'belonging_groups#index'

  get '/me', to: 'users#me'

  resources :invites, only: [:index]

  resources :groups, only: [:show, :new, :create] do
    resources :invites, only: [:new, :create] do
      resources :accepted_invites, only: [:create]
      resources :rejected_invites, only: [:create]
    end

    resources :places, only: [:show, :new, :create, :edit, :update] do
      resources :visited_places, only: [:create]
    end
    resources :group_users, only: [:index]
  end
end
