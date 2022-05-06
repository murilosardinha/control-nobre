# frozen_string_literal: true

module HomeHelper
  def filial_sales_graph(sales, params)
    sales = sales.includes(:destination, :destination_filial).preload(:destination, :destination_filial)
    query = sales.ransack(params)
    sales = query.result.distinct(true)

    sale_ids = sales.map(&:id)
    sale_products = SaleProduct.includes(:product).preload(:product).where(sale_id: sale_ids)
    group = sale_products.group_by(&:product_name)
    group.map{|k, v| 
      [k, v.map(&:quantity).sum]
    }.sort_by{|k, v| -v}
  end
end
