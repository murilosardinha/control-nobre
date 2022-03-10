class ProductsController < ApplicationController
  before_action :authorize_user!
  before_action :set_current_filial
  before_action :set_product, only: %i[ show edit update destroy edit_limited]

  def index
    @q = Product.in_stock.ransack(params[:q])
    @products = @q.result
      .distinct(true)
      .order(:location, :name)
      .page(params[:page])
      .per(100)

    return @scope = @products.where(filial_id: @filial.id).group_by(&:code) unless params[:q]

    @scope = @products.group_by(&:code)
  end

  def new
    @product = @filial.products.new
  end

  def entrances
    @sales = Sale.where(destination_filial_id: @filial.id)
  end

  def edit; end
  def edit_limited; end

  def create
    @product = @filial.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to filial_products_path(@filial), notice: "Produto foi criado com sucesso." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_update_params)
        format.html { redirect_to filial_products_path(@filial), notice: "Produto foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to filial_products_path(@filial), notice: "Produto foi deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def authorize_user!
      authorize :product
    end

    def set_product
      @product = @filial.products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :quantity, :location, :code)
    end
    
    def product_update_params
      params.require(:product).permit(:name, :quantity, :location)
    end
end
