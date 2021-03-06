class ProductsController < ApplicationController
  before_action :authorize_user!
  before_action :set_current_filial
  before_action :set_collection, only: :index
  before_action :set_product, only: %i[ edit update destroy edit_limited, print]

  def index
    @q = Product.item.ransack(params[:q])
    @products = @q.result
      .includes(:filial)
      .order(Arel.sql("CASE WHEN location = '' THEN 'zz' ELSE location END"))
      .order(:name, :reference)
      .page(params[:page])
      .per(100)

    @products = @products.where(filial_id: @filial.id) unless params[:q]
    @sales_size = Sale.where(destination_filial_id: @filial.id).where.not(status: :done).size

    @scope = @products.group_by(&:code)
  end

  def new; end
  
  def edit; end
  def edit_limited; end

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

  def print
    render(layout: 'application_devise')
  end

  def report
    @q = Product.item.in_stock.ransack(params[:q])
    @products = @q.result
      .includes(:filial)
      .order(Arel.sql("CASE WHEN location = '' THEN 'zz' ELSE location END"))
      .order(:name, :reference)

    @products = @products.where(filial_id: @filial.id) unless super_user?
    query_filial_iq = params[:q][:filial_id_eq] if params[:q].present?
    query_filial_name = Filial.find(query_filial_iq).first_name

    filename = "Estoque-#{query_filial_name}-#{Date.today.in_time_zone.strftime('%d-%m-%Y')}.xlsx"
    render xlsx: "Estoque", filename: filename, disposition: 'inline', template: 'reports/products'
  end

  private
    def authorize_user!
      authorize :product
    end

    def set_product
      @product = @filial.products.find(params[:id])
    end

    def set_collection
      @filials = Filial.order(:name).map{|f| [f.name, f.id]}
    end
    
    def product_update_params
      params.require(:product).permit(:code, :product_code, :location)
    end
end
