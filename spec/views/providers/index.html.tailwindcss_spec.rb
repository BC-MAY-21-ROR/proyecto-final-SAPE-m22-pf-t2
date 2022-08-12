require 'rails_helper'

RSpec.describe "providers/index", type: :view do
  before(:each) do
    assign(:providers, [
      Provider.create!(
        name: "Name",
        email: "Email",
        phone: "Phone"
      ),
      Provider.create!(
        name: "Name",
        email: "Email",
        phone: "Phone"
      )
    ])
  end

  it "renders a list of providers" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
  end
end
