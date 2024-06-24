class DayScheduling < ApplicationRecord
  belongs_to :employee, class_name: "Employee"
end
