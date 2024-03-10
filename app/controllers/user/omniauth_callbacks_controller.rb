# frozen_string_literal: true

class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth
  #
  #



  def github
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
         sign_in_and_redirect @user, event: :authentication
         set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
         flash[:error]='There was a problem signing you in through Github. Please register or try signing in later.'
         session['devise.github_data'] = request.env['omniauth.auth'].except(:extra) # Rimuovendo extra perché può sovraccaricare alcuni store di sessione
         redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.valid?
      session[:user_attributes] = @user.attributes
      render :finish_signup
    else
      flash[:error]='There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end


  def finish_signup
    @user = User.find(params[:id])
    if User.data_di_nascita.nil?
      render :finish_signup
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    else
      render :finish_signup
    end
  end

  private

  def user_params
    params.require(:user).permit(:data_di_nascita)
  end
  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end
  #


  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
