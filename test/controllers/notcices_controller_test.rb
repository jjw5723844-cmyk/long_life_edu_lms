require "test_helper"

class NotcicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get notcices_index_url
    assert_response :success
  end
end
