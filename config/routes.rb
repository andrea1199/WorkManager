
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'pages#home'
  get 'pages/home'

  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    get 'signout', to: 'devise/sessions#destroy'
    get 'settings', to: 'devise/registrations#edit'
    get 'signup', to: 'devise/registrations#new'

  end



  resources :companies
  resources :day_schedulings
  resources :salaires


  get 'aziende', to: 'companies#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
