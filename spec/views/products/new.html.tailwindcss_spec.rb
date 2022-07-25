require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      name: "MyString",
      code: "MyString",
      price: 1,
      description: "MyText",
      business: nil
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input[name=?]", "product[name]"

      assert_select "input[name=?]", "product[code]"

      assert_select "input[name=?]", "product[price]"

      assert_select "textarea[name=?]", "product[description]"

      assert_select "input[name=?]", "product[business_id]"
    end
  end
end
