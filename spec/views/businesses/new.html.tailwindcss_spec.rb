require 'rails_helper'

RSpec.describe "businesses/new", type: :view do
  before(:each) do
    assign(:business, Business.new())
  end

  it "renders new business form" do
    render

    assert_select "form[action=?][method=?]", businesses_path, "post" do
    end
  end
end
