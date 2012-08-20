Friendskis::Application.routes.draw do
  root :to => 'welcome#index'
  
  get 'wizards/setup', controller: 'wizards', action: 'setup', as: :setup
  put 'wizards/setup', controller: 'wizards', action: 'update', as: :setup
  get 'wizards/profile', controller: 'wizards', action: 'profile', as: :profile
  get 'wizards/confirm', controller: 'wizards', action: 'confirm', as: :confirm

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  get 'photos/preview', controller: 'photos', action: 'preview', as: :preview
  get '/album', controller: 'photos', action: 'album', as: :album_view
  get 'albums', controller: 'photos', action: 'new', as: :albums
  resources :photos, except: [:new, :edit, :update]
  
  resources :users, only: [:show, :update]
  get '/feed', controller: 'users', action: 'index', as: :users
  
end
