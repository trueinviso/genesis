Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'sessions/new'

  get '/sign_up',  to: 'users#new'
  post '/sign_up', to: 'users#create'

  resources :subscriptions, except: [:index]

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get    '/logout',  to: 'sessions#destroy'

  namespace :admin do
    root 'screens#index'
  end

  root to: 'users#new'
end
