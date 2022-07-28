require 'rails_helper'

RSpec.describe "inventories/show", type: :view do
  before(:each) do
    @inventory = assign(:inventory, Inventory.create!(
      product_description: "Product Description",
      stock: 2,
      incomes: 3,
      outcomes: 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Product Description/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
