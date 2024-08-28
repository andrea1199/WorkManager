class CreateHolidays < ActiveRecord::Migration[7.1]
  def change
    create_table :holidays do |t|
      t.integer :taken
      t.integer :left
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end