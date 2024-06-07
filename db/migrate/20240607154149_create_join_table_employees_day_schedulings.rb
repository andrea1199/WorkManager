class CreateJoinTableEmployeesDaySchedulings < ActiveRecord::Migration[7.1]
  def change
    create_join_table :employees, :day_schedulings, table_name: :employees_day_schedulings do |t|
      t.index [:day_scheduling_id, :employee_id], name: 'index_employees_day_schedulings_on_day_scheduling'
      t.index [:employee_id, :day_scheduling_id], name: 'index_employees_day_Schedulings_on_employee'
    end
  end
end
