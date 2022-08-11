require 'rails_helper'

RSpec.describe "providers/new", type: :view do
  before(:each) do
    assign(:provider, Provider.new(
      name: "MyString",
      email: "MyString",
      phone: "MyString"
    ))
  end

  it "renders new provider form" do
    render

    assert_select "form[action=?][method=?]", providers_path, "post" do

      assert_select "input[name=?]", "provider[name]"

      assert_select "input[name=?]", "provider[email]"

      assert_select "input[name=?]", "provider[phone]"
    end
  end
end
