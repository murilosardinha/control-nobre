class HomeController < ApplicationController
  before_action :set_filial

  def index
    @q = @filial.products.ransack(params[:q])
    @products = @q.result
      .distinct(true)
      .order(:location, :name)
      .page(params[:page])
      .per(100)

    @expenses = @filial.expenses
      .distinct(true)
      .order(id: :desc)
      .first(10)
  end
end