# frozen_string_literal: true

module HomeHelper
  def filial_sales_graph(sales, params)
    query = sales.ransack(params)
    sales = query.result.includes(:destination, :destination_filial).preload(:destination, :destination_filial)

    sale_ids = sales.map(&:id)
    sale_products = SaleProduct.includes(:product).preload(:product).where(sale_id: sale_ids)
    group = sale_products.group_by(&:product_name)
    group.map{|k, v| 
      [k, v.map(&:quantity).sum]
    }.sort_by{|k, v| -v}
  end

  def category_sales_graph(sales, params)
    query = sales.ransack(params)
    sales = query.result.includes(:category).preload(:category)

    group = sales.group_by(&:category_title)
    group.map{|k, v|
      [k || '', v.size]
    }.sort_by{|k, v| k}
  end
end
