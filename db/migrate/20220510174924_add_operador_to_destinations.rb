class AddOperadorToDestinations < ActiveRecord::Migration[7.0]
  def change
    add_column :destinations, :operador, :string
  end
end
