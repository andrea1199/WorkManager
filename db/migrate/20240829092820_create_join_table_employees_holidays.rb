class CreateJoinTableEmployeesHolidays < ActiveRecord::Migration[7.1]
  def change
    create_join_table :employees, :holidays do |t|
      t.index [:employee_id, :holiday_id], name: 'index_employees_holidays_on_employee'
      t.index [:holiday_id, :employee_id], name: 'index_employees_holidays_on_holidays'
    end
  end
end
