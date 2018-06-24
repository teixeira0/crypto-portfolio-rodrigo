require 'test_helper'

class CryptoMarketControllerTest < ActionDispatch::IntegrationTest
  test "should get buy" do
    get crypto_market_buy_url
    assert_response :success
  end

end
