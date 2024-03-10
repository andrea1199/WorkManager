class User::AdditionalInfoController < ApplicationController
  def new
    @user = User.new(session[:user_attributes])
  end

  def create
    @user = User.new(session[:user_attributes].merge(user_params))
    if @user.save
      session.delete(:user_attributes)
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:data_di_nascita)
  end
end
