class CreateSaleCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :title

      t.timestamps
    end

    add_reference :sales, :category, foreign_key: true

    c = Category.create(title: 'Outros')
    Sale.all.update_all(category_id: c.id)
    Destination.all.each{|d| d.update(name: d.name.strip)}
  end
end
