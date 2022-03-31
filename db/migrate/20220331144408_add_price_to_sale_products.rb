class AddPriceToSaleProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :sale_products, :prices, :json
  end
end
