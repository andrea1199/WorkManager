class HolidaysController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @holiday = current_user.holidays.new(holiday_params)
  
      if @holiday.save
        redirect_to user_path(current_user), notice: 'Ferie salvate con successo.'
      else
        redirect_to user_path(current_user), alert: 'Errore nel salvataggio delle ferie.'
      end
    end
  
    private
  
    def holiday_params
      params.require(:holiday).permit(:taken, :left)
    end
  end
  