class DirigentiController < ApplicationController
  def new
    @dirigente = Dirigente.new
    @dipendenti = Dipendente.all
    # altre variabili di istanza per la vista
  end

  def edit
    @dirigente = Dirigente.find(params[:id])
    @dipendenti = Dipendente.all
    # altre variabili di istanza per la vista
  end
end
