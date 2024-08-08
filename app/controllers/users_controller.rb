class UsersController < ApplicationController
  before_action :set_user

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

  def show_selected_user_info
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html { render partial: 'dirigente/user_details', locals: { user: @user } }
    end
  end

  private

  def user_params
    params.require(:user).permit(:nome, :cognome, :data_di_nascita, :email, :descrizione)
  end

  def set_user
    @user = current_user
  end
end
