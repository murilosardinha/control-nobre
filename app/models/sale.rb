class Sale < ApplicationRecord
  belongs_to :filial
  has_many :sale_products, dependent: :destroy
  has_many :products, through: :sale_products, dependent: :destroy

  belongs_to :destination, optional: true
  belongs_to :destination_filial, foreign_key: :destination_filial_id, class_name: "Filial", optional: true

  delegate :name, to: :destination, prefix: :true, allow_nil: true
  delegate :name, to: :destination_filial, prefix: :true, allow_nil: true

  before_save :set_date

  enum status: { open: 0, done: 1, partial: 2}

  def products_name
    products.map(&:name).join(", ")
  end

  def destination_name
    destination.present? ? destination.name : destination_filial.name
  end

  def set_date
    self.date ||= Date.today 
  end

  def total_amount
    sale_products.map(&:total_amount).sum
  end

  def quantity_of_items
    return sale_products.open.map(&:quantity).sum if partial?
    sale_products.map(&:quantity).sum
  end

  def return_items
    sale_products.open.each do |p_sale|
      product = p_sale.product
      product.increase_quantity(p_sale.quantity)
    end
  end
end
