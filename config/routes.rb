Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ImageUploader::UploadEndpoint => "/images/upload"

  get 'sessions/new'

  get '/sign_up',  to: 'users#new'
  post '/sign_up', to: 'users#create'

  resources :subscriptions, except: [:index]
  resources :screens, only: [:index, :show]
  resources :downloaded_screens, only: [:index]
  resources :favorite_screens, only: [:index]
  resources :users, only: [:edit, :update]

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get    '/logout',  to: 'sessions#destroy'

  namespace :admin do
    resources :screens
    resources :categories
    root 'screens#index'
  end

  root to: 'sessions#new'
end
