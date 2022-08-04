require 'rails_helper'

RSpec.describe "Registers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/register/index"
      expect(response).to have_http_status(:success)
    end
  end

end
