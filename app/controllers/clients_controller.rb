class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  def index
    @clients = Client.all
  end

  def show; end

  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to client_url(@client), notice: 'Client was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_url(@client), notice: 'Client was successfully updated.' }
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

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :email, :phone)
  end
end
