class FinancialStateController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @final_expense = Expense.find_by(business_id: current_business)
        @sales = Sale.all
        @resupply = Resupply.all
        @client = Client.all
    end


    def calculate_expense
        total_expense = 0
        final_expense.each do |expense|
            total_expense += expense[:total]
        end
        total_expense = total_expense
    end


    def calculate_sales;end

    def calculate_resupply
        total_resupply = 0
        @resupply.each do |resupply|
            total_resupply += resupply[:cost]
        end
        total_resupply = total_resupply
    end

    def calculate_total
        @total = total_expense + total_resupply 
    end    
end
