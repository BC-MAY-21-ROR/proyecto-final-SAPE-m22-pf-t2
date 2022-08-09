require 'rails_helper'

RSpec.describe "providers/edit", type: :view do
  before(:each) do
    @provider = assign(:provider, Provider.create!(
      name: "MyString",
      email: "MyString",
      phone: "MyString"
    ))
  end

  it "renders the edit provider form" do
    render

    assert_select "form[action=?][method=?]", provider_path(@provider), "post" do

      assert_select "input[name=?]", "provider[name]"

      assert_select "input[name=?]", "provider[email]"

      assert_select "input[name=?]", "provider[phone]"
    end
  end
end
