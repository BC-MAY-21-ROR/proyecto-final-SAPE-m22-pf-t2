require 'rails_helper'

RSpec.describe "expenses/index", type: :view do
  before(:each) do
    assign(:expenses, [
      Expense.create!(
        rent: "9.99",
        salaries: "9.99",
        general_charges: "9.99",
        service_bills: "9.99",
        commissions: "9.99",
        taxes: "9.99",
        business: nil
      ),
      Expense.create!(
        rent: "9.99",
        salaries: "9.99",
        general_charges: "9.99",
        service_bills: "9.99",
        commissions: "9.99",
        taxes: "9.99",
        business: nil
      )
    ])
  end

  it "renders a list of expenses" do
    render
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
