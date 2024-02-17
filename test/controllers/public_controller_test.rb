require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get users" do
    get public_users_url
    assert_response :success
  end
end
