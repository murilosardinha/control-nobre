class FilialsController < ApplicationController
  before_action :set_filial, only: %i[ show edit update destroy ]

  # GET /filials or /filials.json
  def index
    @filials = Filial.all
  end

  # GET /filials/1 or /filials/1.json
  def show
  end

  # GET /filials/new
  def new
    @filial = Filial.new
  end

  # GET /filials/1/edit
  def edit
  end

  # POST /filials or /filials.json
  def create
    @filial = Filial.new(filial_params)

    respond_to do |format|
      if @filial.save
        format.html { redirect_to filial_url(@filial), notice: "Filial was successfully created." }
        format.json { render :show, status: :created, location: @filial }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @filial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filials/1 or /filials/1.json
  def update
    respond_to do |format|
      if @filial.update(filial_params)
        format.html { redirect_to filial_url(@filial), notice: "Filial was successfully updated." }
        format.json { render :show, status: :ok, location: @filial }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @filial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filials/1 or /filials/1.json
  def destroy
    @filial.destroy

    respond_to do |format|
      format.html { redirect_to filials_url, notice: "Filial was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filial
      @filial = Filial.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filial_params
      params.require(:filial).permit(:name, :address)
    end
end
