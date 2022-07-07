class AddStatusToDestination < ActiveRecord::Migration[7.0]
  def change
    add_column :destinations, :status, :integer, default: 1, null: false
  end
end
