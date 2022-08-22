class ProvidersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @pagy, @providers = pagy(current_business.providers)
  end

  def providers_pdf
    @business = current_business
    @providers = @business.providers
    respond_to do |format|
      format.pdf do
        render pdf: "providers_pdf_#{@business.id}",
               template: 'providers/partials/_providers_table_pdf',
               encoding: 'utf8',
               orientation: 'landscape',
               formats: [:html]
      end
    end
  end

  def new
    @provider = Provider.new
  end

  def edit; end

  def create
    @provider = Provider.new(provider_params.merge({ business: current_business }))

    respond_to do |format|
      if @provider.save
        flash = {
          title: 'Provider was created',
          body: "Provider: #{@provider.email} - #{@provider.name} was succesfully created"
        }
        format.html { redirect_to providers_path, success: flash }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @provider.update(provider_params)
        flash = {
          title: "Provider: #{@provider.email} - #{@product.name} was updated"
        }
        format.html { redirect_to providers_path, success: flash }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @provider.destroy

    respond_to do |format|
      flash = {
        title: "Provider: #{@provider.name} was destroyed"
      }
      format.html { redirect_to providers_url, success: flash }
    end
  end

  private

  def provider_params
    params.require(:provider).permit(:name, :email, :phone)
  end
end
