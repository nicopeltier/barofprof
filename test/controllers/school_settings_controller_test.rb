require "test_helper"

class SchoolSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get school_settings_edit_url
    assert_response :success
  end

  test "should get update" do
    get school_settings_update_url
    assert_response :success
  end
end
