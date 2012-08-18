Friendskis::Application.routes.draw do
  root :to => 'welcome#index'
  
  get 'wizards/setup', controller: 'wizards', action: 'setup', as: :setup
  put 'wizards/setup', controller: 'wizards', action: 'update', as: :setup
  get 'wizards/profile', controller: 'wizards', action: 'profile', as: :profile
  post 'wizards/confirm', controller: 'wizards', action: 'confirm', as: :confirm

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  resources :photos, except: [:new, :edit, :update]
  post 'photos/preview', controller: 'photos', action: 'preview', as: :preview
  post '/album', controller: 'photos', action: 'album', as: :album_view
  get 'albums', controller: 'photos', action: 'new', as: :albums
  
  resources :users, only: [:show, :update]
  get '/feed', controller: 'users', action: 'index', as: :users
  
end
