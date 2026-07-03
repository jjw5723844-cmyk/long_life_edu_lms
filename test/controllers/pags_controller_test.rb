require "test_helper"

class PagsControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get pags_about_url
    assert_response :success
  end
end
