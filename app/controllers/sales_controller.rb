class SalesController < ApplicationController
  before_action :set_current_filial
  before_action :set_sale, only: %i[edit update destroy ]

  def index
    @sales = @filial.sales.order(date: :desc)
  end

  def new
    @sale = @filial.sales.new

    @destinations = @filial.destinations.order(:name).map{|d| [d.codename, d.id]}
    @destinations_filials = Filial.order(:name).map{|f| [f.name, f.id]}.select{|k, v| v != @filial.id}
  end

  def edit
    @destinations = @filial.destinations.order(:name).map{|d| [d.codename, d.id]}
    @destinations_filials = Filial.order(:name).map{|f| [f.name, f.id]}.select{|k, v| v != @filial.id}
  end
  
  def show; end

  def entrances
    @sales = Sale.where(destination_filial_id: @filial.id).order(date: :desc)
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

  private
    def set_sale
      @sale = @filial.sales.find(params[:id])
    end

    def sale_params
      params.require(:sale).permit(:destination_id, :destination_filial_id)
    end
end
