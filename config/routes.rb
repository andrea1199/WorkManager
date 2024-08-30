Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }, path_names: { sign_in: 'signin', sign_out: 'signout', sign_up: 'signup' }

  root 'pages#home'
  get 'pages/home'
  get 'chiSiamo', to: 'pages#chiSiamo'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'signin', to: 'users/sessions#new'
    get 'signout', to: 'users/sessions#destroy'
    get 'settings', to: 'users/registrations#edit'
    get 'signup', to: 'users/registrations#new'
  end

  resources :companies
  resources :day_schedulings
  patch '/update_day_scheduling', to: 'day_scheduling#update_day_scheduling', as: 'update_day_scheduling'

  resources :salaires

  resources :users do
    collection do
      get 'confirm', to: 'users#confirm', as: 'confirm'
      get 'show_selected_user_info'
      get 'promote', to: 'users#promote', as: 'promote'
      post 'promote_selected', to: 'users#promote_selected'
      get 'promote_confirm', to: 'users#promote_confirm', as: 'promote_confirm'
      get 'retrocedi', to: 'users#retrocedi', as: 'retrocedi'
      post 'retrocedi_selected', to: 'users#retrocedi_selected'
      get 'retrocedi_confirm', to: 'users#retrocedi_confirm', as: 'retrocedi_confirm'
      get 'complete_profile', to: 'users#complete_profile', as: 'complete_profile'
      patch 'update_profile', to: 'users#update_profile', as: 'update_profile'

    end

    member do
      get 'holidays', to: 'users#show_holidays'
      post 'holidays/update', to: 'users#update_holidays', as: 'update_holidays'
    end
  end

  resources :dirigente, only: [:index, :show], controller: 'dirigente'
  resources :dipendente, only: [:index, :show]
  resources :holidays, only: [:create]


  get 'admin', to: 'admin#index', as: 'admin_index'
  get 'dashboard', to: 'users#dashboard'
  patch 'user_update', to: 'users#update'


  get 'aziende', to: 'companies#index', as: 'aziende_index'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
