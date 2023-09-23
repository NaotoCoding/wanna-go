Rails.application.routes.draw do
  devise_for :users
  root 'belonging_groups#index'
end
