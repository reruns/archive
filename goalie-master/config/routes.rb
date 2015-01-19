Rails.application.routes.draw do
  root to: "sessions#new"

  resources :users, only: [:new, :create, :index] do
    resources :goals, only: [:index]
  end

  resource :session, only: [:new, :create, :destroy]

  resources :goals, except: :index do
    member do
      post 'complete'
    end
  end

  resources :comments, only: [:create]
end
