class CreateMonthlyBudgets < ActiveRecord::Migration[7.2]
  def change
    create_table :monthly_budgets do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :month, null: false
      t.integer :year, null: false
      t.decimal :budget, precision: 10, scale: 2

      t.timestamps
    end
    add_index :monthly_budgets, [ :user_id, :month, :year ], unique: true
  end
end
