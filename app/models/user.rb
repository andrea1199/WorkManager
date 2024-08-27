class User < ApplicationRecord

  has_many :salaires, foreign_key: :employee_id, dependent: :destroy
  has_many :day_schedulings, foreign_key: 'employee_id', dependent: :destroy


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github , :google_oauth2]

  belongs_to :company, optional: true
  before_create :generate_scheduling, :generate_salaires

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #   end
  # end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
  end

  def admin?
    ruolo == 'admin'
  end

  def dirigente?
    ruolo == 'dirigente'
  end

  def dipendente?
    ruolo == 'dipendente'
  end

  private 
  def generate_scheduling
    days_of_week = %w[Monday Tuesday Wednesday Thursday Friday]

    days_of_week.each do |day|
    DayScheduling.create!(
      date: Date.parse(day),               # Giorno della settimana
      start_work: '09:00',                 # Orario di inizio lavoro
      end_work: '17:00',                   # Orario di fine lavoro
      start_break: '13:00',                # Inizio pausa pranzo
      end_break: '14:00',                  # Fine pausa pranzo
      employee_id: self.id                 # Associa l'orario di lavoro all'utente corrente
      )
    end
  end

  def generate_salaires
    # Genera 12 stipendi, uno per ogni mese del 2024
    (1..12).each do |month|
     Salaire.create!(
    date: Date.new(2024, month, 1),   # La data dello stipendio: primo giorno di ogni mese
    value: rand(2000..5000),          # Importo dello stipendio casuale tra 2000€ e 5000€
    employee_id: self.id              # Associa lo stipendio all'utente corrente
    )
    end
  end
end