class SalairesController < ApplicationController
    before_action :set_salaire, only: [:update]

    def index
        # Logica per visualizzare tutti i salari
    end

    def show
        # Logica per visualizzare un salario specifico
    end

    def new
        # Logica per creare un nuovo salario
    end

    def create
        # Logica per salvare un nuovo salario nel database
    end

    def edit
        # Logica per modificare un salario esistente
    end

    def update
        puts "Params: #{params.inspect}"
        if @salaire.update(salaire_params)
          flash[:notice] = 'Stipendio aggiornato con successo.'
          redirect_to user_path(params[:id])
        else
          flash[:error] = 'Errore durante l\'aggiornamento dello stipendio.'
          redirect_to user_path(params[:id])
        end
    end

    def destroy
        # Logica per eliminare un salario esistente dal database
    end

    private

    def set_salaire
        @salaire = Salaire.find(params[:id])
      end

      def salaire_params
        params.require(:salaire).permit(:date, :value)
      end
    
end