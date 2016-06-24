require 'test_helper'

class UserControllerTest < ActionController::TestCase

  def setup
    UnregisteredDevice.create(unique_id: "abc", device_id: 1)
    UnregisteredDevice.create(unique_id: "abcd", device_id: 2)
    User.new(device_id: "abc", email: "sammakman@gmail.com")
  end

  test "user registers" do
    post :create, user:{email: "sam@gmail.com" , unique_id: "abcd" }
    assert_response :success
  end

  test "registration id does not exist" do
  end

  test "email is already registered" do
  end

  test "user is invalid" do
  end
end
