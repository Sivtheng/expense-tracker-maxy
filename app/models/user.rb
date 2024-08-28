class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true, uniqueness: true
    validates :password, presence: true

    has_many :expenses
    has_many :monthly_budgets
end
