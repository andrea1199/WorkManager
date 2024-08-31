class HolidaysController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_manager, only: [:update]

  def create
    @holiday = current_user.holidays.new(holiday_params)

    if @holiday.save
      redirect_to user_path(current_user), notice: 'Ferie salvate con successo.'
    else
      redirect_to user_path(current_user), alert: 'Errore nel salvataggio delle ferie.'
    end
  end

  # Nuova azione per aggiornare le ferie
  def update
    # Troviamo la holiday specifica usando l'ID
    @holiday = current_user.holidays.find(params[:id])

    if @holiday.update(holiday_params)
      redirect_to user_path(current_user), notice: 'Ferie aggiornate con successo.'
    else
      redirect_to user_path(current_user), alert: 'Errore nell\'aggiornamento delle ferie.'
    end
  end

  private

  def holiday_params
    # Aggiungiamo validazioni per impedire che i valori delle ferie siano negativi
    params.require(:holiday).permit(:taken, :left).tap do |whitelisted|
      whitelisted[:taken] = whitelisted[:taken].to_i < 0 ? 0 : whitelisted[:taken]
      whitelisted[:left] = whitelisted[:left].to_i < 0 ? 0 : whitelisted[:left]
    end
  end

  # Nuova logica per autorizzare solo i dirigenti
  def authorize_manager
    unless current_user.manager?
      redirect_to root_path, alert: 'Non sei autorizzato a modificare queste informazioni.'
    end
  end
end

  