class OmniauthController < Devise::OmniauthCallbacksController
require_relative '../models/user.rb' # Add the missing import statement

def github
     @user = User.create_from_provider_data(request.env['omniauth.auth'])
     if @user.persisted?
          sign_in_and_redirect @user
          set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
     else
          flash[:error]='There was a problem signing you in through Github. Please register or try signing in later.'
          redirect_to new_user_registration_url
     end
end
def google_oauth2
      @user = User.create_from_provider_data(request.env['omniauth.auth'])
      if @user.persisted?
           sign_in_and_redirect @user
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
end
