class DirigenteController < ApplicationController
    def index
      @dirigenti = User.where(ruolo: '1')
      Rails.logger.debug "Dirigenti: #{@dirigenti.inspect}"
      @selected_dirigente = User.find(params[:dirigente_id]) if params[:dirigente_id].present?
    end
  
    def show
      @dirigente = User.find(params[:id])
    end
end