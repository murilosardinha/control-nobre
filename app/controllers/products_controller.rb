class ProductsController < ApplicationController
  before_action :set_filial
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = @filial.products.order(:name)
  end

  def new
    @product = @filial.products.new
  end

  def edit; end

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
      if @product.update(product_params)
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
      format.html { redirect_to products_url, notice: "Produto foi deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :quantity)
    end
end
