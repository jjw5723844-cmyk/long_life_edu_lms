require "test_helper"

class FacilityReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get facility_reservations_new_url
    assert_response :success
  end

  test "should get create" do
    get facility_reservations_create_url
    assert_response :success
  end

  test "should get index" do
    get facility_reservations_index_url
    assert_response :success
  end
end
