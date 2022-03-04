class CreateSales < ActiveRecord::Migration[7.0]
  def change

    create_table :destinations do |t|
      t.string :name
      t.string :address
      
      t.references :filial, null: false, foreign_key: true
      t.timestamps
    end


    create_table :sales do |t|
      t.integer :destination_filial_id
      
      t.references :destination, foreign_key: true
      t.references :filial, null: false, foreign_key: true
      t.timestamps
    end
  end
end
