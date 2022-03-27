class ProductPrice < ApplicationRecord
  belongs_to :product

  enum status: { in_stock: 0, done: 1 }

  before_save :check_product

  def check_product
    return if done?

    done! if quantity.zero?
  end
end
