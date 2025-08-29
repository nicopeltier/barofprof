require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get control" do
    get dashboards_control_url
    assert_response :success
  end
end
