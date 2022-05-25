class CreateDamagedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :damaged_items do |t|
      t.string :title
      t.string :delivered_by
      t.text :obs

      t.references :filial, null: false, foreign_key: true

      t.timestamps
    end
  end
end
