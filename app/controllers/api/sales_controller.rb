module Api
  class SalesController < Api::ApiController
    before_action :set_filial

    def show
      if params[:entrance] == 'true'
        # ENTRANCE BY FILIAL
        @sale = Sale.find_by(destination_filial_id: @filial.id, id: params[:id]) 
        @sale_products = @sale.sale_products.open.includes(:product).preload(:product).order("products.name")
        
        codes = @sale_products.map(&:product).map(&:code)
        @current_products = @filial.products.in_stock.where(code: codes)
      else
        # EDIT SALE BY ORIGIN
        @sale = @filial.sales.find(params[:id]) 

        json = @sale.sale_products.open.map do |sale_product|
          {
            id: sale_product.product_id,
            codename: sale_product.product_codename,
            fullname: sale_product.product_fullname,
            code: sale_product.product_code,
            quantity: sale_product.product_quantity + sale_product.quantity,
            qtd_to_sale: sale_product.quantity
          }
        end

        return render json: json
      end
    end

    def receive
      ids = params[:checked_products].map{|p| p[:id]}
      
      @sale = Sale.find_by(destination_filial_id: @filial.id, id: params[:id])
      @sale_products = @sale.sale_products.open.where(id: ids)

      # receive to STOCK
      @sale_products.each do |sale_product|
        checked_products = JSON.parse(params[:checked_products].to_json)
        checked_product = checked_products.find{|p| p['id'] == sale_product.id}
        return unless checked_product

        sale_product.receive(@filial, checked_product['location'])
      end

      # checking conclusion of SALE
      if @sale.sale_products.map(&:status).uniq.size == 1
        @sale.done!
        render json: {status: :ok}
      else
        @sale.partial!
        render json: {status: :pending}
      end
    end

    def set_filial
      @filial = Filial.find(params[:filial_id])
    end
  end
end
