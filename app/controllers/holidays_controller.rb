class HolidaysController < ApplicationController
  before_action :authenticate_user!
  # before_action :authorize_manager, only: [:update]

  def create
    @holiday = current_user.holidays.new(holiday_params)

    if @holiday.save
      redirect_to user_path(current_user), notice: 'Ferie salvate con successo.'
    else
      redirect_to user_path(current_user), alert: 'Errore nel salvataggio delle ferie.'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @holidays = @user.holidays
  end

  def update
    puts "Params: #{params.inspect}"
    @holiday = Holiday.find(params[:id]) # Trova la vacanza specifica
  
    if @holiday.update(holiday_params)
      redirect_to user_path(current_user), notice: 'Ferie aggiornate con successo.'
    else
      redirect_to user_path(current_user), alert: 'Errore nell\'aggiornamento delle ferie.'
    end
  end

  private

  def holiday_params
    params.require(:holiday).permit(:taken, :left).tap do |whitelisted|
      whitelisted[:taken] = whitelisted[:taken].to_i < 0 ? 0 : whitelisted[:taken]
      whitelisted[:left] = whitelisted[:left].to_i < 0 ? 0 : whitelisted[:left]
    end
  end

  # def authorize_manager
  #   unless current_user.manager?
  #     redirect_to root_path, alert: 'Non sei autorizzato a modificare queste informazioni.'
  #   end
  # end
end
