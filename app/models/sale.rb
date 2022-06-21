class Sale < ApplicationRecord
  belongs_to :filial
  belongs_to :category, optional: true

  has_many :sale_products, dependent: :destroy
  has_many :products, through: :sale_products, dependent: :destroy

  belongs_to :destination, optional: true
  belongs_to :destination_filial, foreign_key: :destination_filial_id, class_name: "Filial", optional: true

  delegate :name, to: :destination, prefix: :true, allow_nil: true
  delegate :name, to: :destination_filial, prefix: :true, allow_nil: true
  delegate :title, to: :category, prefix: true, allow_nil: true

  before_save :set_date, :update_quantity

  enum status: { open: 0, done: 1, partial: 2}

  def products_name
    products.map(&:name).join(", ")
  end

  def destination_name
    return "#{destination.codename}" if destination.present?
    
    destination_filial.name
  end

  def set_date
    # self.date ||= Date.today 
  end

  def update_quantity
    self.quantity = sale_products.map(&:quantity).sum
  end

  def total_amount
    sale_products.map(&:total_amount).sum
  end

  def quantity_of_items
    return sale_products.open.map(&:quantity).sum if partial?
    quantity
  end

  def return_items
    sale_products.each do |p_sale|
      product = p_sale.product
      product.increase_quantity(p_sale.quantity)
    end
  end
end
