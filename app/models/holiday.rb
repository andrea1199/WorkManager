class Holiday < ApplicationRecord
    belongs_to :user, foreign_key: :employee_id
  end
  
