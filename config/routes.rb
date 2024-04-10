Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :users, only: [:show]
  resources :employees do
    member do
      resources :assignments, only: [:create, :destroy]
    end
  end
  resources :shifts
end
