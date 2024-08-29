class Holiday < ApplicationRecord
<<<<<<< HEAD
  belongs_to :user

  validates :taken, presence: true
  validates :left, presence: true
end
=======
    belongs_to :user, foreign_key: :employee_id
  end
  
>>>>>>> 88f956b (aggiunta funzionalità ferie dipendente, dirigente ed admin. (seed da rivedere per le ferie))
