require "test_helper"

class PrptotypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prptotypes_index_url
    assert_response :success
  end
end
