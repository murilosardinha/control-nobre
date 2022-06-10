class AddReferenceToMachine < ActiveRecord::Migration[7.0]
  def change
    add_column :machines, :reference, :string
  end
end
