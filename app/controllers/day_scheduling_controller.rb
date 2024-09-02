class DaySchedulingController < ApplicationController
    before_action :set_day_scheduling, only: [:show, :edit, :update, :destroy]

    def index
        # Questa funzione gestisce la visualizzazione di tutti gli orari di lavoro giornalieri
    end

    def show
        # Questa funzione gestisce la visualizzazione di un singolo orario di lavoro giornaliero
    end

    def new
        # Questa funzione gestisce la creazione di un nuovo orario di lavoro giornaliero
    end

    def create
        # Questa funzione gestisce la creazione di un nuovo orario di lavoro giornaliero
    end

    def edit
        # Questa funzione gestisce la modifica di un orario di lavoro giornaliero esistente
    end

    def update
        # Questa funzione gestisce l'aggiornamento di un orario di lavoro giornaliero esistente
    end
 
    def destroy
        # Questa funzione gestisce l'eliminazione di un orario di lavoro giornaliero esistente
    end

    def update_day_scheduling
        user = User.find(params[:user_id])
        # Presupponendo che il formato dei dati sia corretto

        # Questa funzione aggiorna gli orari di lavoro giornalieri per un utente specifico
        # Itera attraverso i parametri "work_schedules" che contengono gli orari di lavoro per ogni giorno
        params[:work_schedules].each do |day, schedule|
          day_scheduling = user.day_schedulings.find_or_initialize_by(date: Date.parse(day.capitalize))
          day_scheduling.start_work = schedule[:start_work]
          day_scheduling.end_work = schedule[:end_work]
          day_scheduling.save!
        end

        redirect_to user_path(user), notice: 'Orario di lavoro aggiornato con successo.'
    end
      
    private

    # Logica per definire i parametri accettabili per la creazione e l'aggiornamento di un orario lavorativo
    def day_scheduling_params
        params.require(:day_scheduling).permit(:date, :start_work, :end_work, :start_break, :end_break, :employee_id)
    end
    
    def set_day_scheduling
        @day_scheduling = DayScheduling.find(params[:id])
    end
end
