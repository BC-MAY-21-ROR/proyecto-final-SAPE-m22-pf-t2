class RegisterController < ApplicationController
  def index
    @products = Product.all
  end
end
