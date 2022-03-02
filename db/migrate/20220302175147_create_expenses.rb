class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.decimal :value
      t.text :obs
      t.references :filial, null: false, foreign_key: true

      t.timestamps
    end
  end
end
