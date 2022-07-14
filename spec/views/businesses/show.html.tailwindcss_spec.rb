require 'rails_helper'

RSpec.describe "businesses/show", type: :view do
  before(:each) do
    @business = assign(:business, Business.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
