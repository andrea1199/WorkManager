class AddEmployeeToSalaires < ActiveRecord::Migration[7.1]
  def change
    add_reference :salaires, :employee, null: false, foreign_key: { to_table: :users}
  end
end
