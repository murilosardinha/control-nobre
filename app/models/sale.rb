class Sale < ApplicationRecord
  belongs_to :filial
  has_many :product_sales, dependent: :destroy
  has_many :products, through: :product_sales, dependent: :destroy

  belongs_to :destination, optional: true
  belongs_to :destination_filial, foreign_key: :destination_filial_id, class_name: "Filial", optional: true

  def products_name
    products.map(&:name).join(", ")
  end

  def destination_name
    destination.present? ? destination.name : destination_filial.name
  end
end
