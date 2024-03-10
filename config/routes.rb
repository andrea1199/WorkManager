Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'user/omniauth_callbacks', additional_info: 'user/additional_infos'
  }

  devise_scope :user do
    get 'additional_info', to: 'additional_infos#create', as: :user_additional_info
    patch 'additional_info', to: 'additional_infos#new'
  end

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


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
