class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = Expense.where(business: current_business).order(month: :desc)
  end

  def show; end

  def new
    @expense = Expense.new
  end

  def edit; end

  def create
    result = Expenses::CreateOrUpdateExpense.call({ business: current_business, expense_params: expense_params })
    @expense = result.expense
    respond_to do |format|
      if result.success?
        flash = {
          title: 'New expense was created',
          body: "Expense for #{@expense.month} was succesfully created."
        }
        format.html { redirect_to expenses_url, success: flash }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    result = Expenses::CreateOrUpdateExpense.call({ business: current_business, expense_params: expense_params })
    @expense = result.expense
    respond_to do |format|
      if result.success?
        flash = {
          title: 'Expense was updated',
          body: "Expense for #{@expense.month} was succesfully updated."
        }
        format.html { redirect_to expenses_path, success: flash }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy
    flash = {
      title: 'Expense was destroyed',
      body: "Expense for #{@expense.month} was succesfully destroyed."
    }
    respond_to do |format|
      format.html { redirect_to expenses_url, success: flash }
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
      :amortizations,
      :taxes
    )
  end
end
