class User < ApplicationRecord

  has_many :salaires, foreign_key: :employee_id, dependent: :destroy
  has_many :day_schedulings, foreign_key: 'employee_id', dependent: :destroy


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
end