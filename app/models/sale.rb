class Sale < ApplicationRecord
  belongs_to :filial
  has_many :sale_products, dependent: :destroy
  has_many :products, through: :sale_products, dependent: :destroy

  belongs_to :destination, optional: true
  belongs_to :destination_filial, foreign_key: :destination_filial_id, class_name: "Filial", optional: true
  
  before_save :set_date

  def products_name
    products.map(&:name).join(", ")
  end

  def destination_name
    destination.present? ? destination.name : destination_filial.name
  end

  def set_date
    self.date ||= Date.today 
  end

  def quantity_of_items
    sale_products.map(&:quantity).sum
  end

  def return_items
    sale_products.each do |p_sale|
      product = p_sale.product
      product.return_quantity(p_sale.quantity)
    end
  end
end
