class ClientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @clients = Client.where(business: current_business)
  end

  def clients_pdf
    @business = current_business
    @clients = @business.clients
    respond_to do |format|
      format.pdf do
        render pdf: "clients_pdf_#{@business.id}",
               template: 'clients/partials/_clients_table_report',
               encoding: 'utf8',
               orientation: 'landscape',
               formats: [:html]
      end
    end
  end

  def show; end

  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params.merge({ business: current_business }))

    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path, notice: 'Client was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_path, notice: 'Client was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :phone)
  end
end
