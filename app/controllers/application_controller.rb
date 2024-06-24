class ApplicationController < ActionController::Base
  # ...
  #

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :cognome, :data_di_nascita, :descrizione, :ruolo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome, :cognome, :data_di_nascita, :descrizione, :ruolo])
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
