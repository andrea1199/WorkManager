class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:promote, :promote_selected]

  def dashboard
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to confirm_users_path # Reindirizza alla pagina di conferma
    else
      render 'users/dashboard'
    end
  end

  def confirm
    render 'users/confirm'
  end
  
  def retrocedi
    # Carica tutti i dipendenti
    @dipendenti = User.where(ruolo: 'dirigente')
  end

  def retrocedi_selected
    # Aggiorna il ruolo dei dipendenti selezionati
    User.where(id: params[:user_ids]).update_all(ruolo: 'dipendente')

    redirect_to retrocedi_confirm_users_path # Reindirizza alla pagina di conferma
  end

  def retrocedi_confirm
    # Renderizza la pagina di conferma
  end

  def promote
    # Carica tutti i dipendenti
    @dipendenti = User.where(ruolo: 'dipendente')
  end

  def promote_selected
    # Aggiorna il ruolo dei dipendenti selezionati
    User.where(id: params[:user_ids]).update_all(ruolo: 'dirigente')

    redirect_to promote_confirm_users_path # Reindirizza alla pagina di conferma
  end

  def promote_confirm
    # Renderizza la pagina di conferma
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

  def authorize_admin
    unless current_user.admin? || current_user.dirigente?
      redirect_to root_path, alert: "Non sei autorizzato ad accedere a questa sezione."
    end
  end
end
