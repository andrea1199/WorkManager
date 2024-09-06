class User < ApplicationRecord

  has_many :salaires, foreign_key: :employee_id, dependent: :destroy
  has_many :day_schedulings, foreign_key: 'employee_id', dependent: :destroy
  has_many :holidays, foreign_key: :employee_id, dependent: :destroy



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github , :google_oauth2]

  belongs_to :company, optional: true

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #   end
  # end

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
end