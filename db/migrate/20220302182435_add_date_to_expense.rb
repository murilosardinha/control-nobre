class AddDateToExpense < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :date, :date
  end
end
