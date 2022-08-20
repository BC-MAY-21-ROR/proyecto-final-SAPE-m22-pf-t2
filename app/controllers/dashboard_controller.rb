class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action do
    ActiveStorage::Current.url_options = {
      protocol: request.protocol,
      host: request.host,
      port: request.port
    }
  end

  def index
    if current_business_id.present?
      @current_business = Business.find_by_id(current_business_id)
      prepare_data
      return
    end

    if current_user.owned_business.present?
      self.current_business = current_user.owned_business
      prepare_data
    else
      redirect_to new_business_path
    end
  end

  def prepare_data
    prepare_general_data
    prepare_chart_data
  end

  def prepare_general_data
    if @current_business.present?
      @clients_count = current_business.clients.count
      @providers_count = current_business.providers.count
      @current_month_sales_total = Sale.total_of_month(current_business, Date.today)
      @current_month_resupplies_total = Resupply.total_of_month(current_business, Date.today)
    else
      redirect_to new_business_path
    end
  end

  def prepare_chart_data
    @graph_data = FinancialState::CalculateLastSemesterFinancialState.call(
      {
        business: current_business
      }
    ).financial_states
  end
end
