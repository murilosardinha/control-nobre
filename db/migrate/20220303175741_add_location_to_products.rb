class AddLocationToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :location, :string
    add_column :products, :code, :string
  end
end
