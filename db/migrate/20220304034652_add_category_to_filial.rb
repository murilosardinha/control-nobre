class AddCategoryToFilial < ActiveRecord::Migration[7.0]
  def change
    add_column :filials, :category, :integer, default: 2, null: false
  end
end
