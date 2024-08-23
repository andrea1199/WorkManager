class DayScheduling < ApplicationRecord
    # Associazione con il modello User
    belongs_to :user, foreign_key: 'employee_id', optional: true
    
    # Validazioni opzionali
    validates :date, :start_work, :end_work, presence: true
  end
  