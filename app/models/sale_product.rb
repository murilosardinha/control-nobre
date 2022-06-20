class SaleProduct < ApplicationRecord
  belongs_to :sale
  belongs_to :product

  delegate :codename, :name, :fullname, :product_code, :code, :quantity, :reference, to: :product, prefix: true

  enum status: { open: 0, done: 1}

  def receive(filial, location)
    filial_product = filial.products.find_or_create_by(
      name: self.product.name,
      reference: self.product.reference,
      code: self.product.code
    )

    if filial_product
      filial_product.increase_quantity(self.quantity) 
      self.done!
    end

    filial_product.update(location: location) if location != filial_product.location
  end

  def total_amount
    prices.map{|p| p['price'].to_f * p['quantity']}.sum
  end
end