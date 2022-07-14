require 'rails_helper'

RSpec.describe "businesses/index", type: :view do
  before(:each) do
    assign(:businesses, [
      Business.create!(),
      Business.create!()
    ])
  end

  it "renders a list of businesses" do
    render
  end
end
