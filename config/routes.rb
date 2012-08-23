Friendskis::Application.routes.draw do
  root :to => 'welcome#index'
  
  get 'wizards/step_one', controller: 'wizards', action: 'step_one', as: :step_one
  put 'wizards/step_one', controller: 'wizards', action: 'update', as: :step_one
  get 'wizards/step_two', controller: 'wizards', action: 'step_two', as: :step_two
  get 'wizards/step_three', controller: 'wizards', action: 'step_three', as: :step_three

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  get 'photos/preview', controller: 'photos', action: 'preview', as: :preview
  get '/album', controller: 'photos', action: 'album', as: :album_view
  get 'albums', controller: 'photos', action: 'new', as: :albums
  resources :photos, except: [:new, :edit, :update]
  
  resources :users, only: [:show, :update]
  get '/feed', controller: 'users', action: 'index', as: :users
  
  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
  
end
