class AddObsToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :obs, :text
  end
end
