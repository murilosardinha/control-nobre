class DestinationsController < ApplicationController
  before_action :set_current_filial
  before_action :set_destination, only: %i[ show edit update destroy ]

  def index
    @q = @filial.destinations.ransack(params[:q])
    @destinations = @q.result
      .in_order_of(:status, %w[active inactive])
      .order(:name)
      .page(params[:page])
      .per(50)
  end

  def show
  end

  def new
    @destination = @filial.destinations.new
  end

  def edit
  end

  def create
    @destination = @filial.destinations.new(destination_params)

    respond_to do |format|
      if @destination.save
        format.html { redirect_to filial_destinations_path(@filial), notice: "Destinação foi criada com sucesso." }
        format.json { render :show, status: :created, location: @destination }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @destination.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @destination.update(destination_params)
        format.html { redirect_to filial_destinations_path(@filial), notice: "Destinação foi atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @destination }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @destination.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @destination.destroy

    respond_to do |format|
      format.html { redirect_to filial_destinations_path(@filial), notice: "Destinação foi deletada com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def set_destination
      @destination = @filial.destinations.find(params[:id])
    end

    def destination_params
      params.require(:destination).permit(:name, :address, :operador, :status)
    end
end
