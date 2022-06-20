class ProductPricesController < ApplicationController
  before_action :authorize_user!
  before_action :set_current_filial
  before_action :set_product_price, only: %i[ edit update destroy edit_limited, print]
  
  def edit; end

  def update
    respond_to do |format|
      if @product_price.update(product_price_params)
        format.html { redirect_to edit_filial_product_path(@filial, @product), notice: "Preço foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def authorize_user!
      authorize :product_price
    end

    def set_product_price
      @product = @filial.products.find(params[:product_id])
      @product_price = @product.product_prices.find(params[:id])
    end

    def product_price_params
      params[:product_price][:price] = format_decimal(params[:product_price][:price])

      params.require(:product_price).permit(:price)
    end
end
