# frozen_string_literal: true

module HomeHelper
  def filial_sales_graph(params)
    query = filial.sales.ransack(params)
    sales = query.result.distinct(true)
    products = sales.map(&:products).flatten.compact
    
    products.map do |product|
      quantity = sales.map{|s| s.product_sales.where(product_id: product_id).map(&:quantity)}.sum
      [product.name, quantity]
    end
  end
end
