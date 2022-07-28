require 'rails_helper'

RSpec.describe "inventories/index", type: :view do
  before(:each) do
    assign(:inventories, [
      Inventory.create!(
        product_description: "Product Description",
        stock: 2,
        incomes: 3,
        outcomes: 4
      ),
      Inventory.create!(
        product_description: "Product Description",
        stock: 2,
        incomes: 3,
        outcomes: 4
      )
    ])
  end

  it "renders a list of inventories" do
    render
    assert_select "tr>td", text: "Product Description".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
  end
end
