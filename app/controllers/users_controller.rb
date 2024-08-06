class UsersController < ApplicationController

  def dashboard
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_path, notice: 'Profile updated successfully.'
    else
      render :dashboard
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :descrizione)
  end
end

  def index
    if params[:ruolo].present?
      @users = User.where(ruolo: params[:ruolo])
    else
      @users = []
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
