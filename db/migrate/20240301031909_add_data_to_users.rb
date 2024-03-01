class AddDataToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nome, :string
    add_column :users, :cognome, :string
    add_column :users, :data_di_nascita, :dateù
    add_column :users, :descrizione, :text
    add_column :users, :ruolo, :string

  end
end
