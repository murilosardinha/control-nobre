class DamagedItemsController < ApplicationController
  before_action :set_current_filial
  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @q = @filial.damaged_items.ransack(params[:q])
    @damaged_items = @q.result
      .order(:created_at)
      .page(params[:page])
      .per(50)
  end

  def show
  end

  def new
    @damaged_item = @filial.damaged_items.new
  end

  def edit
  end

  def create
    @damaged_item = @filial.damaged_items.new(category_params)

    respond_to do |format|
      if @damaged_item.save
        format.html { redirect_to filial_damaged_items_path(@filial), notice: "Item Danificado foi criado com sucesso." }
        format.json { render :show, status: :created, location: @damaged_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @damaged_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @damaged_item.update(category_params)
        format.html { redirect_to filial_damaged_items_path(@filial), notice: "Item Danificado foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @damaged_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @damaged_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @damaged_item.destroy

    respond_to do |format|
      format.html { redirect_to filial_damaged_items_path, filial: "Item Danificado foi deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @damaged_item = @filial.damaged_items.find(params[:id])
    end

    def category_params
      params.require(:damaged_item).permit(:title, :delivered_by, :obs)
    end
end
