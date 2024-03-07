Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  devise_for :users
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

  #ROUTES AGGIUNTE PER USER -> DA RIVEDERE - modifica fatta da @scicamaru

  # Rotta per visualizzare il profilo dell'utente
  # get '/users/:id', to: 'users#show', as: 'user'

  # Rotta per visualizzare il modulo di modifica del profilo dell'utente
  # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'

  # Rotta per gestire l'aggiornamento del profilo dell'utente
  # patch '/users/:id', to: 'users#update'



  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
