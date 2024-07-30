class DirigenteController < ApplicationController
    def index
      @dipendenti = User.where(ruolo: '1')
      Rails.logger.debug "Dirigenti: #{@dirigenti.inspect}"
      @selected_dipendente = User.find(params[:dipendente_id]) if params[:dipendente_id].present?
    end
  
    def show
      @dipendente = User.find(params[:id])
    end
end