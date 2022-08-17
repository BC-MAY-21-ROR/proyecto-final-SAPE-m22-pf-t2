# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def destroy
    super do
      session[:business_id] = nil
      session[:sale_products] = nil
    end
  end
end
