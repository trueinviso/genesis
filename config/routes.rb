Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ImageUploader::UploadEndpoint => "/images/upload"
  mount FileUploader::UploadEndpoint => "/files/upload"
  mount StripeEvent::Engine, at: '/stripe/webhook'

  devise_for :users,
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
    }

  resource :subscription,
    except: [:index, :edit]

  resources :screens,
    only: [:index, :show]

  resources :downloaded_screens,
    only: [:index, :create]

  resources :favorite_screens,
    only: [:index, :create]

  resource :user,
    only: [:update]

  get 'search', to: 'screens#search'

  scope :profile, as: "profile" do
    get "/", to: "user#edit"

    resource :notification,
      controller: :notifications,
      only: [:edit]

    resource :subscription,
      controller: :subscription,
      only: [:edit]

    resource :payment_method,
      controller: :payment_method,
      only: [:edit]
  end

  namespace :admin do
    resources :screens
    resources :categories
    root 'screens#index'
  end

  root to: "screens#index"
end
