class HomeController < ApplicationController
  before_action :set_current_filial

  def index
    @q = @filial.products.ransack(params[:q])
    @products = @q.result
      .distinct(true)
      .order(:location, :name)
      .page(params[:page])
      .per(100)
    
    # SAIDAS
    @sales = @filial.sales
      .order(date: :desc)
      .first(10)

    # DESPESAS
    @expenses = @filial.expenses
      .distinct(true)
      .order(date: :desc)
      .first(10)

    # GRAPHS
    @filials = Filial.order(:name).map{|f| [f.name, f.sales]}
    params[:resume] = {} unless params[:resume].present?

    params[:resume][:date_dategteq] = params[:resume][:date_dategteq].present? ? params[:resume][:date_dategteq] : (Date.today - 7.days)
    params[:resume][:date_datelteq] = params[:resume][:date_datelteq].present? ? params[:resume][:date_datelteq] : Date.today
  end
end