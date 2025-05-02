class User < ApplicationRecord
  attr_accessor :skip_inizializza_campi

  has_many :salaires, foreign_key: :employee_id, dependent: :destroy
  has_many :day_schedulings, foreign_key: 'employee_id', dependent: :destroy
  has_many :holidays, foreign_key: :employee_id, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github , :google_oauth2]

  belongs_to :company, optional: true

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create  do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.nome = provider_data.info.first_name
      user.cognome = provider_data.info.last_name
    end
  end

  acts_as_paranoid

  def status
    deleted_at.present? ? "Disabilitato" : "Attivo"
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

  def inizializza_campi
    if self.day_schedulings.empty?
      days_of_week = %w[Monday Tuesday Wednesday Thursday Friday]
      days_of_week.each do |day|
        self.day_schedulings.create!(
          date: Date.parse(day),
          start_work: '09:00',
          end_work: '17:00',
          start_break: '13:00',
          end_break: '14:00',
          employee_id: self.id
        )
      end
    end
    if self.holidays.empty?
      self.holidays.create!(
        taken: rand(0..15),
        left: rand(0..30),
        employee_id: self.id
      )
    end
    if self.salaires.empty?
      (1..12).each do |month|
        self.salaires.create!(
          date: Date.new(2024, month, 1),
          value: rand(2000..5000),
          employee_id: self.id
        )
      end
    end
  end

  after_commit :inizializza_campi, on: :create, unless: -> { skip_inizializza_campi }

end