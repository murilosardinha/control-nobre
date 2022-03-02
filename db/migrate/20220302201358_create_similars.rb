class CreateSimilars < ActiveRecord::Migration[7.0]
  def change
    create_table :similars do |t|
      t.string :name
      t.text :description
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
