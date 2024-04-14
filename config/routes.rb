Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :users, only: [:show]
  resources :employees
  resources :shifts do
    collection do
      get 'per_day', to: 'shifts#shifts_per_day', as: 'per_day'
    end
  end
  resources :assignments, only: [:create, :destroy] do
    collection do
      post 'refuerzo', to: 'assignments#refuerzo'
    end
  end
end
