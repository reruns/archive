Rails.application.routes.draw do
  root to: redirect("/subs")
  resource :session, only: [:create, :destroy, :new]
  resources :users, only: [:create, :new]

  resources :subs
  resources :posts

  get 'posts/:id/comments/new', to: 'comments#new', as: 'new_comment'
  resources :comments, except: :new
end
