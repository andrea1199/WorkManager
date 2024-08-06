# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
    nome: "dipendente_nome",
    cognome: "dipendente_cognome",
    email: "dipendente@gmail.com",
    password: "password",
    ruolo: "dipendente",
    data_di_nascita: "1990-01-01",
    descrizione: "sono un dipendente"
)

User.create!(
    nome: "dirigente_nome",
    cognome: "dirigente_cognome",
    email: "dirigente@gmail.com",
    password: "password",
    ruolo: "dirigente",
    data_di_nascita: "1990-01-01",
    descrizione: "sono un dirigente"
)

User.create!(
    nome: "admin_nome",
    cognome: "admin_cognome",
    email: "admin@gmail.com",
    password: "password",
    ruolo: "admin",
    data_di_nascita: "1990-01-01",
    descrizione: "sono un admin"
)
