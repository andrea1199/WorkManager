class CreateJoinTableEmployeesSalaires < ActiveRecord::Migration[7.1]
  def change
    create_join_table :employees, :salaires, table_name: :employees_salaires do |t|
      t.index [:salaire_id, :employee_id], name: 'index_employees_salaires_on_salaire'
      t.index [:employee_id, :salaire_id], name: 'index_employees_salaires_on_employee'
    end
  end
end
