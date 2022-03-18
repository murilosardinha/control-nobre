# frozen_string_literal: true

module HomeHelper
  def filial_sales_graph(sales, params)
    sales = sales.includes(:sale_products).preload(:sale_products)
    query = sales.ransack(params)
    sales = query.result.distinct(true)
    products = sales.map(&:products).flatten.compact
    
    products.map do |product|
      quantity = sales.map{|s| s.sale_products.where(product_id: product.id).map(&:quantity)}.flatten.sum
      [product.name, quantity]
    end
  end
end
