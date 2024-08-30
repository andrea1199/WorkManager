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
        user = User.find(params[:user_id])
        # Presupponendo che il formato dei dati sia corretto
        params[:work_schedules].each do |day, schedule|
          day_scheduling = user.day_schedulings.find_or_initialize_by(date: Date.parse(day.capitalize))
          day_scheduling.start_work = schedule[:start_work]
          day_scheduling.end_work = schedule[:end_work]
          day_scheduling.save!
        end
        redirect_to user_path(user), notice: 'Orario di lavoro aggiornato con successo.'
      end
      
    private

    def day_scheduling_params
        params.require(:day_scheduling).permit(:date, :start_work, :end_work, :start_break, :end_break, :employee_id)
    end
    
    def set_day_scheduling
        @day_scheduling = DayScheduling.find(params[:id])
    end
end
