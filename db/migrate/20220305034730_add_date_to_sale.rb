class AddDateToSale < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :date, :date
  end
end
