class SalesController < ApplicationController
  before_action :set_current_filial
  before_action :set_sale, only: %i[edit update destroy consult ]
  before_action :set_collection, only: [:index, :new, :edit]

  def index
    @q = @filial.sales.ransack(params[:q])
    @sales = @q.result
      .includes(:destination, :destination_filial, :products, :category, sale_products: :product)
      .order(date: :desc)
      .page(params[:page])
      .per(100)
  end

  def new
    @sale = @filial.sales.new
  end

  def edit
  end
  
  def show; end
  def consult; end

  def entrances
    @sales = Sale.where(destination_filial_id: @filial.id).order(id: :desc)
  end

  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to filial_sales_path(@filial), notice: "Venda foi atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sale.return_items
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to filial_sales_path(@filial), notice: "Venda foi deletada com sucesso." }
      format.json { head :no_content }
    end
  end

  def report
    @q = @filial.sales.ransack(params[:q])
    @sales = @q.result
      .includes(:destination, :destination_filial, :category, sale_products: :product)
      .order(date: :asc)
      # .order("destinations.name asc")
      # .order("destination_filial.name asc")
      # .order("date asc")

    @uniq_destination = @sales.map(&:destination_name).uniq.size == 1
    @destination = @sales.map(&:destination_name).uniq.first
    query_filial_name = @filial.first_name

    filename = "Baixas-#{query_filial_name}.xlsx"
    render xlsx: "Baixas", filename: filename, disposition: 'inline', template: 'reports/sales'
  end

  private
    def set_sale
      @sale = @filial.sales.find(params[:id])
    end

    def set_collection
      @destinations = @filial.destinations.order(:name).collect{|d| [d.codename, d.id]}
      @destinations_filials = Filial.order(:name).collect{|f| [f.name, f.id]}.select{|k, v| v != @filial.id}
      @categories = Category.order(:title).collect{|c| [c.title, c.id] }
    end

    def sale_params
      params.require(:sale).permit(:destination_id, :destination_filial_id, :category_id, :date)
    end
end
