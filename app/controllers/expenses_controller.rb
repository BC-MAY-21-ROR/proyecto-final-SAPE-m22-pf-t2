class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]


  def index
    @expenses = Expense.all
  end

  def show; end

  def new
    @expense = Expense.new
  end

  def edit; end

  def create

    
    @expense = Expense.new(expense_params.merge({ business: current_business }))
    respond_to do |format|
      if @expense.save
        format.html { redirect_to expense_url, notice: 'Expense was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def first_expense
    unless @expenses.nil?
      @first_expense = First(@expenses)
    else
      format.html { , status: :unprocessable_entity }
  end

  def check_expense_month
    current_expense = First(Expense.find_by(month: current_expense.month))
    @expenses.each do |i|
      if i.month !== current_expense.month
        return true
      else
        flash[:alert]  = "This expense is repeated"
        returns false
      end
    end
  end


  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Expense was successfully updated.' }
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

  def set_limit 
    @expenses
  end

 
  def expense_params
    puts params
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
