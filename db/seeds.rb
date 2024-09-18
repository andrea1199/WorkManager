# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Aziende predefinite

ActiveRecord::Base.connection.truncate_tables(*ActiveRecord::Base.connection.tables)


Company.create!(
  name: "a"
)
Company.create!(
  name: "b"
)


# Utenti predefiniti
User.create!(
  nome: "dipendente_nome",
  cognome: "dipendente_cognome",
  email: "dipendente@gmail.com",
  password: "password",
  ruolo: "dipendente",
  data_di_nascita: "1990-01-01",
  descrizione: "sono un dipendente",
  company_id: Company.find_by(name: "a").id
)

User.create!(
  nome: "dipendente_b",
  cognome: "dipendente_b",
  email: "dipendenteb@gmail.com",
  password: "password",
  ruolo: "dipendente",
  data_di_nascita: "1990-01-01",
  descrizione: "sono un dipendente",
  company_id: Company.find_by(name: "b").id
)

User.create!(
  nome: "dirigente_nome",
  cognome: "dirigente_cognome",
  email: "dirigente@gmail.com",
  password: "password",
  ruolo: "dirigente",
  data_di_nascita: "1990-01-01",
  descrizione: "sono un dirigente",
  company_id: Company.find_by(name: "a").id
)

User.create!(
  nome: "dirigente2_nome",
  cognome: "dirigente2_cognome",
  email: "dirigente2@gmail.com",
  password: "password",
  ruolo: "dirigente",
  data_di_nascita: "1990-01-01",
  descrizione: "sono un dirigente",
  company_id: Company.find_by(name: "b").id
)

User.create!(
  nome: "admin_nome",
  cognome: "admin_cognome",
  email: "admin@gmail.com",
  password: "password",
  ruolo: "admin",
  data_di_nascita: "1990-01-01",
  descrizione: "sono un admin",
  company_id: Company.find_by(name: "a").id
)

User.create!(
  nome: "admin2_nome",
  cognome: "admin2_cognome",
  email: "admin2@gmail.com",
  password: "password",
  ruolo: "admin",
  data_di_nascita: "1990-01-01",
  descrizione: "sono un admin",
  company_id: Company.find_by(name: "b").id
)

############################################ SPOSTATI IN USER MODEL ############################################
# # Creati alla creazione dell'utente da user.rb


# # Aggiunta degli stipendi per ogni utente
# User.all.each do |user|
#   # Genera 12 stipendi, uno per ogni mese del 2024
#   (1..12).each do |month|
#     Salaire.create!(
#       date: Date.new(2024, month, 1),   # La data dello stipendio: primo giorno di ogni mese
#       value: rand(2000..5000),          # Importo dello stipendio casuale tra 2000€ e 5000€
#       employee_id: user.id              # Associa lo stipendio all'utente corrente
#     )
#   end
# end

# Aggiunta degli orari di lavoro per ogni utente
# User.all.each do |user|
#   days_of_week = %w[Monday Tuesday Wednesday Thursday Friday]

#   days_of_week.each do |day|
#     DayScheduling.create!(
#       date: Date.parse(day),               # Giorno della settimana
#       start_work: '09:00',                 # Orario di inizio lavoro
#       end_work: '17:00',                   # Orario di fine lavoro
#       start_break: '13:00',                # Inizio pausa pranzo
#       end_break: '14:00',                  # Fine pausa pranzo
#       employee_id: user.id                 # Associa l'orario di lavoro all'utente corrente
#     )
#   end
# end


# Aggiunta delle vacanze per ogni utente
# User.all.each do |user|
#   Holiday.create!(
#     taken: rand(0..15),
#     left: rand(0..30),
#     employee_id: user.id
#   )
# end
