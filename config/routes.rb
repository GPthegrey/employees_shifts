Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :users, only: [:show]
  resources :employees do
    member do
      resources :assignments
    end
  end
  resources :shifts do
    collection do
      get 'per_day', to: 'shifts#shifts_per_day', as: 'per_day'
    end
  end
end
