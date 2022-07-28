require 'rails_helper'

RSpec.describe "expenses/new", type: :view do
  before(:each) do
    assign(:expense, Expense.new(
      rent: "9.99",
      salaries: "9.99",
      general_charges: "9.99",
      service_bills: "9.99",
      commissions: "9.99",
      taxes: "9.99",
      business: nil
    ))
  end

  it "renders new expense form" do
    render

    assert_select "form[action=?][method=?]", expenses_path, "post" do

      assert_select "input[name=?]", "expense[rent]"

      assert_select "input[name=?]", "expense[salaries]"

      assert_select "input[name=?]", "expense[general_charges]"

      assert_select "input[name=?]", "expense[service_bills]"

      assert_select "input[name=?]", "expense[commissions]"

      assert_select "input[name=?]", "expense[taxes]"

      assert_select "input[name=?]", "expense[business_id]"
    end
  end
end
