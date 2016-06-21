require 'test_helper'

class ApiControllerTest < ActionController::TestCase

  def setup
  @dev = UnregisteredDevice.create(device_id: 1, unique_id: "abcd")

  end

  test "should get registration code" do
      get(:unregistered,{'device_id' =>  12123})
      assert_response :success
      res = JSON.parse(@response.body)
      assert_equal "Device is not Registered", res["message"]
  end

  test "get regcode should show device in database" do
    get(:regcode,{'device_id' =>  1})
    assert_response :success
    res = JSON.parse(@response.body)
    assert_equal "abcd", res["registration_id"]
  end
end
