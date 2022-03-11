module Api
  class ProductsController < Api::ApiController
    before_action :set_filial

    def index
      query = @filial.products.in_stock.order(:name)

      json = query.map do |p|
        {
          id: p.id,
          codename: p.codename,
          fullname: p.fullname,
          code: p.code,
          location: p.location,
          quantity: p.quantity,
          qtd_to_sale: 1
        }
      end

      render json: json
    end

    def orders
      products = params[:selectedProducts]
      product_ids = products.map{|p| p[:id]}

      @sale = @filial.sales.build(
        destination_id: params[:destination_id], 
        destination_filial_id: params[:destination_filial_id]
      )
      
      products.each do |p|
        product = @filial.products.find_by(id: p[:id])
        next unless p[:qtd_to_sale]
        
        quantity = product.decrease_quantity(p[:qtd_to_sale])
        next unless quantity > 0

        @sale.sale_products.build(
          product_id: p[:id],
          quantity: quantity
        )
      end

      if @sale.sale_products.size > 0
        @sale.save!
        render json: {status: :ok}
      else
        render json: {status: :error}
      end
    end

    def set_filial
      @filial = Filial.find(params[:filial_id])
    end
  end
end
