class CreateSalaires < ActiveRecord::Migration[7.1]
  def change
    create_table :salaires do |t|
      t.date :date
      t.integer :value

      t.timestamps
    end
  end
end
