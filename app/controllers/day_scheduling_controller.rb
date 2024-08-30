class DaySchedulingController < ApplicationController
    before_action :set_day_scheduling, only: [:show, :edit, :update, :destroy]

    def index
        # Add code here
    end

    def show
        # Add code here
    end

    def new
        # Add code here
    end

    def create
        # Add code here
    end

    def edit
        # Add code here
    end

    def update
        # Add code here
    end
 
    def destroy
        # Add code here
    end

    def update_day_scheduling
        if current_user.ruolo != "dipendente"
            params[:work_schedules].each do |day, times|
                schedule = current_user.day_schedulings.find_or_initialize_by(date: Date.parse(day.capitalize))
      
                if times[:start_work].present? && times[:end_work].present?
                  schedule.update(
                   start_work: Time.zone.parse(times[:start_work]),
                    end_work: Time.zone.parse(times[:end_work])
                  )
                end
            end
            flash[:success] = "Orario di lavoro aggiornato con successo."
        else
          flash[:error] = "Non hai i permessi per modificare l'orario di lavoro."
        end
        redirect_to day_schedulings_path(current_user)
    end

    private

    def day_scheduling_params
        params.require(:day_scheduling).permit(:date, :start_work, :end_work, :start_break, :end_break, :employee_id)
    end
    
    def set_day_scheduling
        @day_scheduling = DayScheduling.find(params[:id])
    end
end
