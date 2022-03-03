class SimilarsController < ApplicationController
  before_action :set_item
  before_action :set_similar, only: %i[ show edit update destroy ]

  def index
    @similars = @item.similars.order(:name)
  end

  def show
  end

  def new
    @similar = @item.similars.new
  end

  def edit
  end

  def create
    @similar = @item.similars.new(similar_params)

    respond_to do |format|
      if @similar.save
        format.html { redirect_to filial_machine_item_similars_path(@filial, @machine, @item), notice: "Paralelo foi criado com sucesso." }
        format.json { render :show, status: :created, location: @similar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @similar.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @similar.update(similar_params)
        format.html { redirect_to filial_machine_item_similars_path(@filial, @machine, @item), notice: "Paralelo foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @similar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @similar.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @similar.destroy

    respond_to do |format|
      format.html { redirect_to similars_url, notice: "Paralelo foi deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def set_item
      set_filial
      @machine = @filial.machines.find(params[:machine_id])
      @item = @machine.items.find(params[:item_id])
    end

    def set_similar
      @similar = Similar.find(params[:id])
    end

    def similar_params
      params.require(:similar).permit(:name, :description)
    end
end
