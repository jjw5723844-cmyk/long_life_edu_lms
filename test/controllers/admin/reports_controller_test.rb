require "test_helper"

class Admin::ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_reports_index_url
    assert_response :success
  end

  test "should get export_csv" do
    get admin_reports_export_csv_url
    assert_response :success
  end
end
