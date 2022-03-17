json.array! @sale_products do |sale_product|
  json.(sale_product, :id, :product_code, :product_name, :product_fullname, :quantity, :product_id)

  current_product = @current_products.select{|p| p.code == sale_product.product_code }[0]
  json.current_location current_product ? current_product.location : "-"
end
