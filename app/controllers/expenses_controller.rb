class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = Expense.all.order(month: :desc)
  end

  def show; end

  def new
    @expense = Expense.new
  end

  def edit; end

  def create
    result = Expenses::CreateOrUpdateExpense.call({ business: current_business, expense_params: })
    @expense = result.expense
    respond_to do |format|
      if result.success?
        format.html { redirect_to expenses_url, notice: 'Expense was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    result = Expenses::CreateOrUpdateExpense.call({ business: current_business, expense_params: })
    @expense = result.expense
    respond_to do |format|
      if result.success?
        format.html { redirect_to expenses_path, notice: 'Expense was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(
      :month,
      :rent,
      :salaries,
      :general_charges,
      :service_bills,
      :commissions,
      :taxes
    )
  end
end
