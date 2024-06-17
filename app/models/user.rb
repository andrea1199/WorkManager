class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :omniauthable, omniauth_providers: [:github, :google_oauth2]

<<<<<<< HEAD
belongs_to :companies
=======
  belongs_to :company
>>>>>>> ebc3826 (ruby tables relations+ gmail + errors fix ruby version)

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create  do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.nome = provider_data.info.first_name
      user.cognome = provider_data.info.last_name
    end
  end


end
