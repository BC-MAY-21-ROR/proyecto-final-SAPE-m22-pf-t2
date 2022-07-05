class LandingPageController < ApplicationController
  def index
    puts current_admin.email
  end
end
