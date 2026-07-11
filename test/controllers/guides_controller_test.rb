require "test_helper"

class GuidesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get guides_index_url
    assert_response :success
  end

  test "should get registration" do
    get guides_registration_url
    assert_response :success
  end

  test "should get facility" do
    get guides_facility_url
    assert_response :success
  end
end
