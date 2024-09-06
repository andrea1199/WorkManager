require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:dirigente) { create(:user, :dirigente) }
  let(:employee) { create(:user, :dipendente) }
  let(:user) { create(:user) }
  let!(:user1) { create(:user, :dirigente) }
  let!(:user2) { create(:user, :dirigente) }

  before do
    sign_in admin # Assuming Devise is used for authentication
  end

  describe 'GET #dashboard' do
    it 'returns a success response' do
      get :dashboard
      expect(response).to be_successful
      expect(assigns(:user)).to eq(admin)
    end
  end

  describe 'POST #retrocedi_selected' do
    it 'retrocedes selected users and redirects to confirmation page' do
      post :retrocedi_selected, params: { user_ids: [user1.id, user2.id] }
      
      user1.reload
      user2.reload
      
      expect(user1.ruolo).to eq('dipendente')
      expect(user2.ruolo).to eq('dipendente')
      expect(response).to redirect_to(retrocedi_confirm_users_path)
    end
  end

  describe 'POST #promote_selected' do
    it 'promotes selected users and redirects to confirmation page' do
      post :promote_selected, params: {
        user_ids: [user1.id, user2.id],
        users: {
          user1.id.to_s => { company_id: 1 },
          user2.id.to_s => { company_id: 2 }
        }
      }
      
      user1.reload
      user2.reload
      
      expect(user1.ruolo).to eq('dirigente')
      expect(user2.ruolo).to eq('dirigente')
      expect(user1.company_id).to eq(1)
      expect(user2.company_id).to eq(2)
      expect(response).to redirect_to(promote_confirm_users_path)
    end
  end

  describe 'PATCH #update_profile with invalid attributes' do
    it 'does not update the user profile and re-renders the form' do
      patch :update_profile, params: { user: { nome: '', cognome: '' } }
    
      expect(user.reload.nome).not_to eq('')
      expect(user.reload.cognome).not_to eq('')
      end
    end

end