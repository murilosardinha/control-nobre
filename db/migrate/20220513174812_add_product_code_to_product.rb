class AddProductCodeToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :product_code, :string
  end
end
