Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }, path_names: { sign_in: 'signin', sign_out: 'signout', sign_up: 'signup' }

  root 'pages#home'
  get 'pages/home'
  get 'chiSiamo', to: 'pages#chiSiamo'

  devise_scope :user do
    get 'signin', to: 'users/sessions#new'
    get 'signout', to: 'users/sessions#destroy'
    get 'settings', to: 'users/registrations#edit'
    get 'signup', to: 'users/registrations#new'
  end

  resources :companies
  resources :day_schedulings
  patch '/update_day_scheduling', to: 'day_scheduling#update_day_scheduling', as: 'update_day_scheduling'

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

      # Aggiunta delle rotte per soft delete, ripristino ed eliminazione definitiva
      get 'licenzia', to: 'users#licenzia', as: 'licenzia'
      post 'licenzia_selected', to: 'users#licenzia_selected', as: 'licenzia_selected'
      get 'licenzia_confirm', to: 'users#licenzia_confirm', as: 'licenzia_confirm'
      post 'restore', to: 'users#restore', as: 'restore'
      delete 'destroy_permanently', to: 'users#destroy_permanently', as: 'destroy_permanently'
    end
  
    member do
      get 'holidays', to: 'holidays#show'
      patch 'update_holidays', to: 'holidays#update', as: 'update_holidays'
      patch 'update_salaire/:id', to: 'salaires#update', as: 'update_salaire'
    end
  end
  
  resources :dirigente, only: [:index, :show], controller: 'dirigente'
  resources :dipendente, only: [:index, :show]
  resources :holidays, only: [:create, :update]
  resources :salaires, only: [:show, :edit, :update]

  get 'admin', to: 'admin#index', as: 'admin_index'
  get 'dashboard', to: 'users#dashboard'
  patch 'user_update', to: 'users#update'

  get 'aziende', to: 'companies#index', as: 'aziende_index'
  get "up" => "rails/health#show", as: :rails_health_check
end
