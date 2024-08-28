class MonthlyBudget < ApplicationRecord
  belongs_to :user

  validates :month, :year, :budget, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validates :user_id, uniqueness: { scope: [ :month ] }
end
