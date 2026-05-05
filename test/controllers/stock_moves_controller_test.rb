require "test_helper"

class StockMovesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stock_moves_index_url
    assert_response :success
  end
end
