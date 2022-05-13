class AddCategoryToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :category, :integer, default: 1, null: false
  end
end
