class Holiday < ApplicationRecord
  belongs_to :user, foreign_key: :employee_id

  validates :user, presence: true
end
