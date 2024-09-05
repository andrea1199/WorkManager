class UsersController < ApplicationController
  before_action :set_user, only: [:show, :show_selected_user_info]
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:promote, :promote_selected, :retrocedi, :retrocedi_selected, :licenzia, :licenzia_selected]
  
  # Metodo per visualizzare la dashboard dell'utente corrente
  def dashboard
    @user = current_user
  end

  # Metodo per visualizzare le informazioni di un dipendente selezionato
  def show_selected_user_info
    @user = User.find(params[:user_id])
    month = params[:month].present? ? Date.parse(params[:month]) : Date.current.beginning_of_month

    @salaires = @user.salaires.where(date: month.beginning_of_month..month.end_of_month).order(date: :asc)
    @holiday = @user.holidays.first_or_initialize

    if @salaires.empty?
      flash[:alert] = "Nessuna informazione sullo stipendio disponibile per il mese selezionato."
    end

    if current_user.dirigente?
      render 'dirigente/dipendente', locals: { user: @user }
    elsif current_user.admin?
      render 'admin/user_details', locals: { user: @user }
    else
      redirect_to root_path, alert: "Non autorizzato a visualizzare queste informazioni."
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Utente non trovato."
    redirect_to root_path
  end
  
  # Metodo per aggiornare il profilo dell'utente
  def update_profile
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = 'Profilo aggiornato con successo.'
      redirect_to root_path
    else
      flash[:error] = 'Errore durante l\'aggiornamento del profilo.'
      render :complete_profile
    end
  end

  # Metodo per retrocedere gli utenti selezionati
  def retrocedi_selected
    User.where(id: params[:user_ids]).update_all(ruolo: 'dipendente')
    redirect_to retrocedi_confirm_users_path
  end

  # Metodo per promuovere gli utenti selezionati
  def promote_selected
    user_ids = params[:user_ids] || []
    user_data = params[:users] || {}

    user_data.each do |user_id, data|
      user = User.find_by(id: user_id)
      next unless user

      user_updates = {}

      if user_ids.include?(user_id)
        user_updates[:ruolo] = 'dirigente' if user.ruolo != 'dirigente'
      end

      if data[:company_id].present? && data[:company_id].to_i != user.company_id
        user_updates[:company_id] = data[:company_id].to_i
      end

      user.update(user_updates) if user_updates.any?
    end

    redirect_to promote_confirm_users_path
  end

  # Metodo per promuovere un utente
  def promote
    @dipendenti = User.where(ruolo: 'dipendente')
  end

  # Metodo per visualizzare la conferma di promozione
  def promote_confirm
    # Renderizza la pagina di conferma
  end

  # Metodo per visualizzare la conferma di retrocessione
  def retrocedi_confirm
    # Renderizza la pagina di conferma
  end

  # Metodo per licenziare gli utenti selezionati
  def licenzia_selected
    User.where(id: params[:user_ids]).destroy_all
    redirect_to licenzia_confirm_users_path
  end

  # Metodo per visualizzare la pagina di licenziamento
  def licenzia
    @dipendenti = User.where(ruolo: 'dipendente')
  end

  # Metodo per visualizzare la conferma di licenziamento
  def licenzia_confirm
    # Renderizza la pagina di conferma
  end

  # Metodo per visualizzare la lista degli utenti
  def index
    @users = params[:ruolo].present? ? User.where(ruolo: params[:ruolo]) : []
  end

  # Metodo per visualizzare i dettagli di un utente specifico
  def show
    @user = User.find(params[:id])
    @holiday = @user.holidays.first_or_initialize
  end

  private

  # Imposta l'utente corrente per le azioni che richiedono un utente specifico
  def set_user
    @user = User.find(params[:user_id] || params[:id])
  end

  # Permette solo i parametri permessi per l'utente
  def user_params
    params.require(:user).permit(:nome, :cognome, :data_di_nascita, :descrizione, :ruolo, :company_id)
  end

  # Autorizza solo gli amministratori e dirigenti
  def authorize_admin
    redirect_to root_path, alert: "Non sei autorizzato ad accedere a questa sezione." unless current_user.admin? || current_user.dirigente?
  end
end

