require 'rails_helper'

RSpec.feature "LicenziaDipendenti", type: :feature do
  let!(:user) { create(:user, nome: "Mario", cognome: "Rossi", email: "mario.rossi@example.com", ruolo: "dipendente") }
  let!(:deleted_user) { create(:user, nome: "Luca", cognome: "Bianchi", email: "luca.bianchi@example.com", ruolo: "dipendente", deleted_at: Time.now) }
  let!(:admin) { create(:user, :admin) }
 

  before do
    login_as(admin, scope: :user)
    visit root_path
    click_on 'Licenzia Dipendenti'

  end

  scenario 'mostra correttamente la tabella con i dipendenti' do
    expect(page).to have_content("Licenzia Dipendenti")
    expect(page).to have_content(user.nome)
    expect(page).to have_content(user.cognome)
    expect(page).to have_content(user.email)
    expect(page).to have_content(deleted_user.nome)
    expect(page).to have_content(deleted_user.cognome)
    expect(page).to have_content(deleted_user.email)
  end

  scenario 'mostra correttamente lo stato del dipendente (Attivo o Disabilitato)' do
    within("#user-#{user.id}") do
        expect(page).to have_css(".badge-primary", text: "Attivo")
    end

    within("#user-#{deleted_user.id}") do
      expect(page).to have_css(".badge-secondary", text: "Disabilitato")
    end
  end

  scenario 'seleziona dipendenti da soft deletare, ripristinare o eliminare definitivamente' do
    within("#user-#{user.id}") do
      check "user_ids[soft_delete][]"
    end

    within("#user-#{deleted_user.id}") do
      check "user_ids[restore][]"
    end

    click_button 'Applica Azioni'
    
    expect(page).to have_content("Azione Completata!")
  end
end
