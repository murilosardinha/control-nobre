class ProductPrice < ApplicationRecord
  belongs_to :product

  enum status: { in_stock: 0, done: 1 }

  before_save :check_product

  def check_product
    return if done?

    done! if quantity.zero?
  end

  def self.find_prices(product_prices, quantity, args = [])
    product_price = product_prices.max_by(&:price)
    return args.push({quantity: quantity, price: 0}) unless product_price

    result = product_price.quantity - quantity

    if result >= 0
      used_quantity = quantity
      product_price.update(quantity: result)
    else
      used_quantity = quantity - product_price.quantity
      product_price.update(quantity: 0)
      find_prices((product_prices - [product_price]), used_quantity, args)
    end
    
    return args.push({quantity: used_quantity, price: product_price.price})
  end

end
