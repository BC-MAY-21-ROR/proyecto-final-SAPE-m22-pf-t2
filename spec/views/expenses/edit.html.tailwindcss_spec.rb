require 'rails_helper'

RSpec.describe "expenses/edit", type: :view do
  before(:each) do
    @expense = assign(:expense, Expense.create!(
      rent: "9.99",
      salaries: "9.99",
      general_charges: "9.99",
      service_bills: "9.99",
      commissions: "9.99",
      taxes: "9.99",
      business: nil
    ))
  end

  it "renders the edit expense form" do
    render

    assert_select "form[action=?][method=?]", expense_path(@expense), "post" do

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
