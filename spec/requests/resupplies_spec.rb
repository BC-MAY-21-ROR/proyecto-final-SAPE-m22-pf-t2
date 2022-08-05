require 'rails_helper'

RSpec.describe "Resupplies", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/resupplies/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/resupplies/show"
      expect(response).to have_http_status(:success)
    end
  end

end
