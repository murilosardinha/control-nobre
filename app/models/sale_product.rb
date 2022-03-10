class SaleProduct < ApplicationRecord
  belongs_to :sale
  belongs_to :product

  delegate :name, to: :product, prefix: true
end
