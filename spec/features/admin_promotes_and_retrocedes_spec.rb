require 'rails_helper'

RSpec.feature "Admin manages employee promotions and demotions", type: :feature do
  let!(:admin) { create(:user, :admin) }
  let!(:company) { Company.find_by(name: "Default Company") }
  let!(:employee) { create(:user, :dipendente, company: company) }
  let!(:director) { create(:user, :dirigente, company: company) }

  before do
    login_as(admin, scope: :user)
  end

  scenario "Admin promotes an employee to executive" do
    visit root_path
    click_on 'Promuovi Dipendenti' # Attiva la tab 'Promuovi Dipendenti'
    within('#promote') do
      check "user_ids[]", match: :first
      click_button 'Promuovi Selezionati'
    end
    expect(page).to have_content("Promozione Completata!")

    # Ricarica la pagina e verifica se la promozione è avvenuta
    visit root_path
    click_on 'Dirigenti' # Attiva la tab 'Dirigenti'
    
    # Debug: salva e apri la pagina per controllare il contenuto
    save_and_open_page

    within('#dirigenti') do
      expect(page).to have_content(director.nome)
    end
  end

  scenario "Admin demotes an executive to employee" do
    visit root_path
    click_on 'Retrocedi Dirigenti' # Attiva la tab 'Retrocedi Dirigenti'
    within('#retrocedi') do
      check "user_ids[]", match: :first
      click_button 'Retrocedi Selezionati'
    end
    expect(page).to have_content("Retrocessione Completata!")

    # Ricarica la pagina e verifica se la retrocessione è avvenuta
    visit root_path
    click_on 'Dipendenti' # Attiva la tab 'Dipendenti'
    
    # Debug: salva e apri la pagina per controllare il contenuto
    save_and_open_page

    within('#dipendenti') do
      expect(page).to have_content(employee.nome)
    end
  end
end
