module Api
  class ProductsController < Api::ApiController
    before_action :set_filial

    def index
      query = @filial.products.order(:name)

      json = query.map do |p|
        {
          id: p.id,
          name: p.name,
          codename: p.codename,
          fullname: p.fullname,
          code: p.code,
          product_code: p.product_code,
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
        if @sale.destination.present?
          @sale.status = :done 
          @sale.sale_products.map(&:done!)
        end

        @sale.save!
        render json: {status: :ok}
      else
        render json: {status: :error}
      end 
    end

    def new_order
      @sale = @filial.sales.build(
        destination_id: params[:destination_id], 
        destination_filial_id: params[:destination_filial_id],
        category_id: params[:category_id],
        date: params[:date]
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
          quantity: p[:qtd_to_sale],
          prices: Product.find_prices(product.code, p[:qtd_to_sale])
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
          # add item quantity to STOCK (remove items from order)
          increase = sale_product.quantity - p[:qtd_to_sale].to_i
          result = product.increase_quantity(increase)
        else
          # remove item quantity from STOCK (add items to order)
          decrease = p[:qtd_to_sale].to_i - sale_product.quantity
          result = product.decrease_quantity(decrease)
        end

        next unless result

        # update order
        sale_product.update(quantity: p[:qtd_to_sale])
      end

      # REMOVE FROM ORDER && RETURN TO STOCK
      ids = JSON.parse(@products.to_enum.to_json).map{|p| p['id']}
      return_item = @sale.product_ids - ids
      return unless return_item.any?

      sale_product = @sale.sale_products.find_by(product_id: return_item)
      sale_product.product.increase_quantity(sale_product.quantity)
      @sale.product_ids = ids
    end

    def create_products
      params[:products].each do |new_product|
        code = new_product[:code]
        product_code = new_product[:product_code]
        category = new_product[:category]
        
        product = nil

        if product_code.presence
          product = Product.find_or_initialize_by(product_code: product_code, filial_id: @filial.id, category: category)
        elsif code.presence
          product = Product.find_or_initialize_by(code: code, filial_id: @filial.id, category: category)
        else
          product = Product.find_or_initialize_by(name: new_product[:name].squish, filial_id: @filial.id, category: category)
        end

        quantity = format_number(new_product[:quantity])
        price = format_decimal(new_product[:price])

        if product.new_record?
          product.quantity = quantity.presence || 1
          product.name = new_product[:name].squish
          product.reference = new_product[:reference]
          product.location = new_product[:location].presence || '-'
          product.product_code = product_code
          product.code = code
          
          product.save
        else
          product.update(location: new_product[:location]) unless new_product[:location].blank? && product.location != new_product[:location]
          product.increase_quantity(quantity)
        end

        product.product_prices.create(quantity: quantity, price: price, created_at: new_product[:created_at] || Date.today)
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
        item_param[1]['product_prices_attributes']["0"][:price] = format_decimal(item_param[1]['product_prices_attributes']["0"][:price])
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
