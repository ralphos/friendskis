Friendskis::Application.routes.draw do
  
  match '/subscription' => 'welcome#subscription', as: :subscription

  root :to => 'welcome#index'
  

  match '/payments_callback' => 'welcome#payments_callback'
  match '/payments_callback2' => 'welcome#payments_callback'

  get 'wizards/step_one', controller: 'wizards', action: 'step_one', as: :step_one
  put 'wizards/step_one', controller: 'wizards', action: 'update', as: :step_one
  get 'wizards/step_two', controller: 'wizards', action: 'step_two', as: :step_two
  get 'wizards/step_three', controller: 'wizards', action: 'step_three', as: :step_three

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'sessions/test_login' => "sessions#test_login"
 
  get 'add-caption', controller: 'photos', action: 'add_caption', as: :add_caption
  get '/album-photos', controller: 'photos', action: 'album_photos', as: :album_photos
  get '/pick-album', controller: 'photos', action: 'pick_album', as: :pick_album

  resources :photos, except: [:new, :edit, :update] do
    member do
      post :like
      get :like
    end
  end
  
  resources :users, only: [:show, :update]
  get '/feed', controller: 'users', action: 'index', as: :users
  
  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
  
  get '/account', controller: 'settings', action: 'account', as: :account
  get '/notifications', controller: 'settings', action: 'notifications', as: :notifications
  get '/privacy', controller: 'settings', action: 'privacy', as: :privacy
  get '/credits', controller: 'settings', action: 'credits', as: :credits
  
  match '/about' => 'static_pages#about'
  match '/faq' => 'static_pages#faq'
  match '/terms' => 'static_pages#terms'
  match '/privacy-policy' => 'static_pages#privacy', as: :privacy_policy
  
  resources :visitors, only: [:index]
end
