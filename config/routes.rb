Friendskis::Application.routes.draw do
  root :to => 'welcome#index'

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  resources :photos, except: [:edit, :update]
  post 'photos/confirm', controller: 'photos', action: 'preview', as: :preview
  post '/album', controller: 'photos', action: 'album', as: :album_view
  
  get '/feed', controller: 'users', action: 'index', as: :users
  
end
