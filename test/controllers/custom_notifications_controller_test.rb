require 'test_helper'

class CustomNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get custom_notifications_index_url
    assert_response :success
  end

end
