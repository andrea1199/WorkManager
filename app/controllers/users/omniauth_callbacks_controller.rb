# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  require_relative '../../models/user.rb' # Add the missing import statement

  def after_sign_up_path_for_github(resource)
    sign_in(resource)

    if missing_user_info(resource)
      '/users/omniauth_callbacks/github'
    else
      redirect_to root_path
    end
  end


  def after_sign_up_path_for_google(resource)
    sign_in(resource)

    if missing_user_info(resource)
      '/users/omniauth_callbacks/google'
    else
      redirect_to root_path
    end
  end



  def github
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      after_sign_up_path_for_github(@user)
      # sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      flash[:error]='There was a problem signing you in through Github. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      after_sign_up_path_for_google(@user)
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      flash[:error]='There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end

  def passthru
    flash[:error] = 'passthu errror'
    redirect_to new_user_registration_url
  end

  private

  def missing_user_info(user)
    return user.nome.blank? || user.cognome.blank? || user.data_di_nascita.blank? || user.descrizione.blank?
  end

end
