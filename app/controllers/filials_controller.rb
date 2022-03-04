class FilialsController < ApplicationController
  before_action :authorize_user!
  before_action :set_filial
  before_action :set_filial_item, only: %i[ show edit update destroy ]

  def index
    @filials = Filial.order(:id)
  end

  def show
  end

  def new
    @filial = Filial.new
  end

  def edit
  end

  def create
    @filial = Filial.new(filial_params)

    respond_to do |format|
      if @filial.save
        format.html { redirect_to filials_path, notice: "Filial foi criada com sucesso." }
        format.json { render :show, status: :created, location: @filial }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @filial.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @filial.update(filial_params)
        format.html { redirect_to filials_path, notice: "Filial foi atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @filial }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @filial.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @filial.destroy

    respond_to do |format|
      format.html { redirect_to filials_url, notice: "Filial foi deletada com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def authorize_user!
      authorize :filial
    end

    def set_filial_item
      @filial = Filial.find(params[:id])
    end

    def filial_params
      params.require(:filial).permit(:name, :address, :category)
    end
end
