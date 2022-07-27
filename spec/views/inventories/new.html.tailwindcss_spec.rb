require 'rails_helper'

RSpec.describe "inventories/new", type: :view do
  before(:each) do
    assign(:inventory, Inventory.new(
      product_description: "MyString",
      stock: 1,
      incomes: 1,
      outcomes: 1
    ))
  end

  it "renders new inventory form" do
    render

    assert_select "form[action=?][method=?]", inventories_path, "post" do

      assert_select "input[name=?]", "inventory[product_description]"

      assert_select "input[name=?]", "inventory[stock]"

      assert_select "input[name=?]", "inventory[incomes]"

      assert_select "input[name=?]", "inventory[outcomes]"
    end
  end
end
