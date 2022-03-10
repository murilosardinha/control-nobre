class AddReferenceToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :reference, :string
  end
end
