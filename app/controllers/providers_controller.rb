class ProvidersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @pagy, @providers = pagy(current_business.providers)
  end

  def new
    @provider = Provider.new
  end

  def edit; end

  def create
    @provider = Provider.new(provider_params.merge({ business: current_business }))

    respond_to do |format|
      if @provider.save
        format.html { redirect_to providers_path, notice: 'Provider was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to providers_path, notice: 'Provider was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'Provider was successfully destroyed.' }
    end
  end

  private

  def provider_params
    params.require(:provider).permit(:name, :email, :phone)
  end
end
