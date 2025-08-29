require "test_helper"

class SurveysControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get surveys_new_url
    assert_response :success
  end

  test "should get create" do
    get surveys_create_url
    assert_response :success
  end

  test "should get show" do
    get surveys_show_url
    assert_response :success
  end

  test "should get launch" do
    get surveys_launch_url
    assert_response :success
  end

  test "should get remind" do
    get surveys_remind_url
    assert_response :success
  end

  test "should get close" do
    get surveys_close_url
    assert_response :success
  end

  test "should get report" do
    get surveys_report_url
    assert_response :success
  end
end
