# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(name: 'sivtheng', password: 'sivtheng24032002')
User.create!(name: 'guest', password: 'password')


User.find_each do |user|
  (1..12).each do |month|
    MonthlyBudget.create!(
      user: user,
      month: month,
      year: Date.today.year,
      budget: 0 # Initialize with a budget of 0
    )
  end
end
