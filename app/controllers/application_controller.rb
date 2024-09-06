class ApplicationController < ActionController::Base
  # ...
  #
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :cognome, :data_di_nascita, :descrizione, :ruolo, :company_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome, :cognome, :data_di_nascita, :descrizione, :ruolo, :company_id])
  end

  protected


end
