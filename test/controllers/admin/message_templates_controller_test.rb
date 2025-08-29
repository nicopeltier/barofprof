require "test_helper"

class Admin::MessageTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_message_templates_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_message_templates_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_message_templates_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_message_templates_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_message_templates_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_message_templates_destroy_url
    assert_response :success
  end
end
