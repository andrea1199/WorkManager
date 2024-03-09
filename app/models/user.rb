class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :omniauthable, omniauth_providers: [:github, :google_oauth2]

  def self.create_from_provider_data(provider_data)
    if (provider_data.provider == 'github')
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create  do |user|
        user.email = provider_data.info.email
        user.password = Devise.friendly_token[0, 20]

      end
    elsif (provider_data.provider == 'google_oauth2')
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create  do |user|
        user.email = provider_data.info.email
        user.password = Devise.friendly_token[0, 20]
        user.nome = provider_data.info.first_name
        user.cognome = provider_data.info.last_name
      end
    end
  end


end
