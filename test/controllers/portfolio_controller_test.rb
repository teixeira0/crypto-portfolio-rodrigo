require 'test_helper'

class PortfolioControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get portfolio_view_url
    assert_response :success
  end

end
