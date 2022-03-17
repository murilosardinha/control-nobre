class AddDoneToSale < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :status, :integer, default: 0, null: false
    add_column :sale_products, :status, :integer, default: 0, null: false
  end
end
