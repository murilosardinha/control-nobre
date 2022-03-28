module Api
  class ProductsController < Api::ApiController
    before_action :set_filial

    def index
      query = @filial.products.in_stock.order(:name)

      json = query.map do |p|
        {
          id: p.id,
          name: p.name,
          codename: p.codename,
          fullname: p.fullname,
          code: p.code,
          location: p.location,
          quantity: p.quantity,
          reference: p.reference,
          qtd_to_sale: 1
        }
      end

      render json: json
    end

    def orders
      @products = params[:selectedProducts]
      params[:sale_id].presence ? edit_order : new_order 

      # update status of ORDER
      if @sale.sale_products.size > 0
        @sale.status = :done if @sale.destination.present?
        @sale.save!
        render json: {status: :ok}
      else
        render json: {status: :error}
      end 
    end

    def new_order
      @sale = @filial.sales.build(
        destination_id: params[:destination_id], 
        destination_filial_id: params[:destination_filial_id]
      )
      
      @products.each do |p|
        product = @filial.products.find_by(id: p[:id])
        next unless p[:qtd_to_sale]
        
        # remove from stock
        result = product.decrease_quantity(p[:qtd_to_sale])
        next unless result

        # add in order
        @sale.sale_products.build(
          product_id: p[:id],
          quantity: p[:qtd_to_sale]
        )
      end     
    end

    def edit_order
      @sale = @filial.sales.find(params[:sale_id])

      @products.each do |p|
        product = @filial.products.find_by(id: p[:id])
        next unless p[:qtd_to_sale]
        
        sale_product = @sale.sale_products.find_or_create_by(product_id: product.id)
        sale_product.quantity ||= 0
        # update stock

        if sale_product.quantity > p[:qtd_to_sale]
          # return item to STOCK
          increase = sale_product.quantity - p[:qtd_to_sale].to_i
          result = product.increase_quantity(increase)
        else
          # remote item from STOCK
          decrease = p[:qtd_to_sale].to_i - sale_product.quantity
          result = product.decrease_quantity(decrease)
        end

        next unless result

        # update order
        sale_product.update(quantity: p[:qtd_to_sale])
      end
    end

    def create_products
      params[:products].each do |new_product|
        code = new_product[:code]
        product = Product.find_or_initialize_by(code: code, filial_id: @filial.id)
        quantity = format_number(new_product[:quantity])
        price = format_number(new_product[:price])

        if product.new_record?
          product.quantity = quantity
          product.name = new_product[:name]
          product.reference = new_product[:reference]
          product.location = new_product[:location]
          
          product.save
        else
          product.update(location: new_product[:location]) unless new_product[:location].blank? && product.location != new_product[:location]
          product.increase_quantity(quantity)
        end

        product.product_prices.create(quantity: quantity, price: price)
      end
      
      render json: {status: :ok}
    end

    private

    def set_filial
      @filial = Filial.find(params[:filial_id])
    end

    def product_create_params
      return unless params[:filial].present?
      return unless params[:filial][:products_attributes].present?
  
      params[:filial][:products_attributes].each do |item_param|
        item_param[1]['product_prices_attributes']["0"][:price] = format_number(item_param[1]['product_prices_attributes']["0"][:price])
        item_param[1]['product_prices_attributes']["0"][:quantity] = format_number(item_param[1]['product_prices_attributes'][:quantity])
      end
  
      params.require(:filial).permit(
        :id,
        products_attributes: [
          :id,
          :name,
          :reference,
          :location,
          :code,
          product_prices_attributes: [
            :id,
            :price,
            :quantity
          ]
        ]
      )
    end
  end
end
