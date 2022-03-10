class ChangeColumnToProducts < ActiveRecord::Migration[7.0]
  def up
    change_column :products, :quantity, 'integer USING CAST(quantity AS integer)'
  end
  def down
    change_column :products, :quantity, :string
  end
end
