class AddDataToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nome, :string
    add_column :users, :cognome, :string
    add_column :users, :data_di_nascita, :date
    add_column :users, :descrizione, :text
    add_column :users, :ruolo, :string, default: 'dipendente'

  end
end
