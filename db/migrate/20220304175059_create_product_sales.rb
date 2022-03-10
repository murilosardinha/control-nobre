class CreateProductSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sale_products do |t|
      t.integer :quantity

      t.references :product, null: false, foreign_key: true
      t.references :sale, null: false, foreign_key: true

      t.timestamps
    end
  end
end
