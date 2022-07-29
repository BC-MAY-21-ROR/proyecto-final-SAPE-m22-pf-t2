require 'rails_helper'

RSpec.describe "expenses/show", type: :view do
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

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
