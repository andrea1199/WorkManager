class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new(session['devise.user_attributes'] || {})
    super
  end

  def create
    build_resource(sign_up_params)

    if session['devise.user_attributes']
      resource.attributes = session['devise.user_attributes']
      resource.password = Devise.friendly_token[0, 20] if resource.password.blank?
      session['devise.user_attributes'] = nil
    end

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :cognome, :data_di_nascita, :company_id])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome, :cognome, :data_di_nascita, :company_id])
  end
end
