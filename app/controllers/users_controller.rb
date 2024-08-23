class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!


  def dashboard
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to dashboard_path, notice: 'Profilo aggiornato con successo.'
    else
      render 'users/dashboard'
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
    @salaires = @user.salaires.order(date: :asc) # Carica gli stipendi dell'utente
    if current_user.dirigente?
      render 'dirigente/dirigenteSuInfoPersonali', locals: { user: @user }
    elsif current_user.admin?
      render 'admin/user_details', locals: { user: @user }
    else
      redirect_to root_path, alert: "Non autorizzato a visualizzare queste informazioni."
    end
  end
  
  
  private

  def user_params
    params.require(:user).permit(:email, :descrizione)
  end

  def set_user
    @user = current_user
  end
end
