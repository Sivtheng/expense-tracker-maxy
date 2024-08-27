class RenameDiscriptionToDescriptionInExpenses < ActiveRecord::Migration[7.2]
  def change
    rename_column :expenses, :descriotion, :description
  end
end
