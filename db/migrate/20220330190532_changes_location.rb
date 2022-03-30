class ChangesLocation < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :location, :string, default: ''
  end
end
