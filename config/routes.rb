Friendskis::Application.routes.draw do
  root :to => 'welcome#index'
  
  get 'wizards/step_one', controller: 'wizards', action: 'step_one', as: :step_one
  put 'wizards/step_one', controller: 'wizards', action: 'update', as: :step_one
  get 'wizards/step_two', controller: 'wizards', action: 'step_two', as: :step_two
  get 'wizards/step_three', controller: 'wizards', action: 'step_three', as: :step_three

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  get 'add-caption', controller: 'photos', action: 'add_caption', as: :add_caption
  get '/album-photos', controller: 'photos', action: 'album_photos', as: :album_photos
  get '/pick-album', controller: 'photos', action: 'pick_album', as: :pick_album
  resources :photos, except: [:new, :edit, :update]
  
  resources :users, only: [:show, :update]
  get '/feed', controller: 'users', action: 'index', as: :users
  
  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
  
end
