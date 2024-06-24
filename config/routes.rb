Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'pages#home'
  get 'pages/home'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'settings', to: 'devise/registrations#edit'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  resources :companies
  resources :day_schedulings
  resources :salaires
  resources :users

  get 'aziende', to: 'companies#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
