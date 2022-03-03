class ItemsController < ApplicationController
  before_action :set_machine
  before_action :set_item, only: %i[ show edit update destroy ]

  def index
    @items = @machine.items.order(:name)
  end

  def show
  end

  def new
    @item = @machine.items.new
  end

  def edit
  end

  def create
    @item = @machine.items.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to filial_machine_items_path(@filial, @machine), notice: "Item foi criado com sucesso." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to filial_machine_items_path(@filial, @machine), notice: "Item foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item foi deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def set_machine
      set_filial
      @machine = @filial.machines.find(params[:machine_id])
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description)
    end
end
