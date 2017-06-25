Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ImageUploader::UploadEndpoint => "/images/upload"

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :subscriptions, except: [:index]
  resources :screens, only: [:index, :show]
  resources :downloaded_screens, only: [:index]
  resources :favorite_screens, only: [:index]
  resources :users, only: [:update]

  get 'search', to: 'screens#search'

  get 'profile', to: 'users#edit'
  get 'profile/notifications', to: 'users#notifications'
  get 'profile/subscription', to: 'users#edit_subscription'

  namespace :admin do
    resources :screens
    resources :categories
    root 'screens#index'
  end

  root to: "screens#index"
end
