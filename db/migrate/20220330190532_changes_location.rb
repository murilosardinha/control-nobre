class ChangesLocation < ActiveRecord::Migration[7.0]
  def up
    change_column :products, :location, :string, default: '-'
  end
  def down
    change_column :products, :location, :string
  end

end
