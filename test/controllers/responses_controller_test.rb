require "test_helper"

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get responses_show_url
    assert_response :success
  end

  test "should get answer" do
    get responses_answer_url
    assert_response :success
  end
end
