class CreateJoinTableDirectorsEmployees < ActiveRecord::Migration[7.1]
  def change
    create_join_table :directors, :employees, table_name: :directors_employees do |t|
      t.index [:employee_id, :director_id], name: 'index_directors_employees_on_employee'
      t.index [:director_id, :employee_id], name: 'index_directors_employees_on_director'
    end
  end
end
