require 'rails_helper'

RSpec.describe "inventories/edit", type: :view do
  before(:each) do
    @inventory = assign(:inventory, Inventory.create!(
      product_description: "MyString",
      stock: 1,
      incomes: 1,
      outcomes: 1
    ))
  end

  it "renders the edit inventory form" do
    render

    assert_select "form[action=?][method=?]", inventory_path(@inventory), "post" do

      assert_select "input[name=?]", "inventory[product_description]"

      assert_select "input[name=?]", "inventory[stock]"

      assert_select "input[name=?]", "inventory[incomes]"

      assert_select "input[name=?]", "inventory[outcomes]"
    end
  end
end
