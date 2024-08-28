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
    @dipendenti = User.where(ruolo: 'dirigente')
  end

  def retrocedi_selected
    User.where(id: params[:user_ids]).update_all(ruolo: 'dipendente')
    redirect_to retrocedi_confirm_users_path # Reindirizza alla pagina di conferma
  end

  def retrocedi_confirm
    # Renderizza la pagina di conferma
  end

  def promote
    @dipendenti = User.where(ruolo: 'dipendente')
  end

  def promote_selected
    user_ids = params[:user_ids] || []
    user_data = params[:users] || {}

    user_data.each do |user_id, data|
      user = User.find_by(id: user_id)
      next unless user # Salta se l'utente non esiste

      user_updates = {}

      if user_ids.include?(user_id)
        user_updates[:ruolo] = 'dirigente' if user.ruolo != 'dirigente'
      end

      if data[:company_id].present? && data[:company_id].to_i != user.company_id
        user_updates[:company_id] = data[:company_id].to_i
      end

      user.update(user_updates) if user_updates.any?
    end

    redirect_to promote_confirm_users_path # Reindirizza alla pagina di conferma
  end

  def promote_confirm
    # Renderizza la pagina di conferma
  end

  def index
    @users = params[:ruolo].present? ? User.where(ruolo: params[:ruolo]) : []
  end

  def show
    @user = User.find(params[:id])
    @holiday = @user.holidays.first_or_initialize # Carica le ferie esistenti o inizializza un nuovo oggetto Holiday
  end

  def show_selected_user_info
    @user = User.find(params[:user_id])
    @salaires = @user.salaires.order(date: :asc)
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
    redirect_to root_path, alert: "Non sei autorizzato ad accedere a questa sezione." unless current_user.admin? || current_user.dirigente?
  end
end  