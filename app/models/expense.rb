class Expense < ApplicationRecord
  belongs_to :category

  validates :amount, presence: true
  validates :category_id, presence: true
end
