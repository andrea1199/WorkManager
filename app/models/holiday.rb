class Holiday < ApplicationRecord
  belongs_to :user

  validates :taken, presence: true
  validates :left, presence: true
end
