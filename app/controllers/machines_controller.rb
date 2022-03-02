class MachinesController < ApplicationController
  before_action :set_filial
  before_action :set_machine, only: %i[ show edit update destroy ]

  def index
    @machines = @filial.machines.order(:name)
  end

  def show
  end

  def new
    @machine = @filial.machines.new
  end

  def edit
  end

  def create
    @machine = @filial.machines.new(machine_params)

    respond_to do |format|
      if @machine.save
        format.html { redirect_to filial_machines_path(@filial), notice: "machine was successfully created." }
        format.json { render :show, status: :created, location: @machine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @machine.update(machine_params)
        format.html { redirect_to filial_machines_path(@filial), notice: "machine was successfully updated." }
        format.json { render :show, status: :ok, location: @machine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @machine.destroy

    respond_to do |format|
      format.html { redirect_to machine_index_url, notice: "machine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_machine
      @machine = @filial.machines.find(params[:id])
    end

    def machine_params
      params.require(:machine).permit(:name)
    end
end
