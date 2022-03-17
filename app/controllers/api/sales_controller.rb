module Api
  class SalesController < Api::ApiController
    before_action :set_filial

    def show
      if params[:entrance] == 'true'
        # ENTRANCE BY FILIAL
        @sale = Sale.find_by(destination_filial_id: @filial.id, id: params[:id]) 
        @sale_products = @sale.sale_products.includes(:product).preload(:product).order("products.name")
        
        codes = @sale_products.map(&:product).map(&:code)
        @current_products = @filial.products.in_stock.where(code: codes)
      else
        # EDIT SALE BY ORIGIN
        @sale = @filial.sales.find(params[:id]) 

        json = @sale.sale_products.map do |sale_product|
          {
            id: sale_product.product_id,
            codename: sale_product.product_codename,
            fullname: sale_product.product_fullname,
            code: sale_product.product_code,
            quantity: sale_product.product_quantity,
            qtd_to_sale: sale_product.quantity
          }
        end
        
        return render json: json
      end
    end

    def receive
      ids = params[:checked_products].map{|p| p[:id]}
      
      @sale = Sale.find_by(destination_filial_id: @filial.id, id: params[:id])
      @sale_products = @sale.sale_products.where(id: ids)
      
      @sale_products.each do |sale_product|
        checked_products = JSON.parse(params[:checked_products].to_json)
        checked_product = checked_products.find{|p| p['id'] == sale_product.id}
        return unless checked_product

        sale_product.receive(@filial, checked_product['location'])
      end

      if @sale_products.map(&:status).uniq[0] == 'done'
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
