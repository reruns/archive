Mzk::Application.routes.draw do
  post '/session', to: 'sessions#create', as: 'session'
  get '/session/new', to: 'sessions#new', as: 'new_session'
  delete '/session', to: 'sessions#destroy'
  post '/users', to: 'users#create', as: 'users'
  get '/users/new', to: 'users#new', as: 'new_user'

  #the grammar. Pls.
  #pls.
  get '/bands', to: 'bands#index', as: 'bands'
  get '/bands/new', to: 'bands#new', as: 'new_band'
  get '/bands/:id', to: 'bands#show', as: 'band'
  get '/bands/:id/edit', to: 'bands#edit', as: 'edit_band'


  resource :bands, except: [:show, :edit, :new]

  get '/bands/:band_id/albums/new', to: 'albums#new', as: 'new_band_album'
  get '/albums/:id', to: 'albums#show', as: 'album'
  get '/albums/:id/edit', to: 'albums#edit', as: 'edit_album'
  resource :albums, except: [:show, :new, :edit]

  get '/album/:album_id/tracks/new', to: 'tracks#new', as: 'new_album_track'
  get '/tracks/:id/edit', to: 'tracks#edit', as: 'edit_track'
  get '/tracks/:id', to: 'tracks#show', as: 'track'
  resource :tracks, except: [:show, :new, :edit]

  resource :notes, only: [:create, :destroy]
end
