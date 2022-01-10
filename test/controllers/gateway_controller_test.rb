require 'test_helper'

class GatewayControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get gateway_create_url
    assert_response :success
  end

end
