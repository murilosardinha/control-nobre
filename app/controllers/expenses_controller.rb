class ExpensesController < ApplicationController
  before_action :set_filial
  before_action :set_expense, only: %i[ edit update destroy ]

  def index
    @expenses = @filial.expenses.order(id: :desc)
  end

  def new
    @expense = @filial.expenses.new
  end

  def edit
  end

  def create
    @expense = @filial.expenses.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to filial_expenses_path(@expense), notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to filial_expenses_path(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_expense
      @expense = @filial.expenses.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:title, :value, :obs, :date)
    end
end
