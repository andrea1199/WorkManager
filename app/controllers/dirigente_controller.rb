class DirigenteController < ApplicationController
    def index
      @dirigenti = User.where(role: 'dirigente')
      Rails.logger.debug "Dirigenti: #{@dirigenti.inspect}"
      @selected_dirigente = User.find(params[:dirigente_id]) if params[:dirigente_id].present?
    end
  
    def show
      @dirigente = User.find(params[:id])
    end
end