require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#admin?' do
    it 'returns true if the user is an admin' do
      admin_user = User.new(ruolo: 'admin')
      expect(admin_user.admin?).to be true
    end

    it 'returns false if the user is not an admin' do
      non_admin_user = User.new(ruolo: 'dipendente')
      expect(non_admin_user.admin?).to be false
    end
  end

  describe '#dirigente?' do
    it 'returns true if the user is a dirigente' do
      dirigente_user = User.new(ruolo: 'dirigente')
      expect(dirigente_user.dirigente?).to be true
    end

    it 'returns false if the user is not a dirigente' do
      non_dirigente_user = User.new(ruolo: 'dipendente')
      expect(non_dirigente_user.dirigente?).to be false
    end
  end

  describe '#dipendente?' do
    it 'returns true if the user is a dipendente' do
      dipendente_user = User.new(ruolo: 'dipendente')
      expect(dipendente_user.dipendente?).to be true
    end

    it 'returns false if the user is not a dipendente' do
      non_dipendente_user = User.new(ruolo: 'dirigente')
      expect(non_dipendente_user.dipendente?).to be false
    end
  end
end
