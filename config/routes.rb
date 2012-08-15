Friendskis::Application.routes.draw do
  root :to => 'welcome#index'

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  
  get 'photos/new', controller: 'photos', action: 'new', as: 'new_photo'
  post 'photos/confirm', controller: 'photos', action: 'confirm', as: 'confirm_photo'
end
