class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.string :descriotion
      t.decimal :amount
      t.date :date
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
