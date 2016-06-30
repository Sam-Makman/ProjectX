require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user=User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  test "passowrd_reset" do
    mail = UserMailer.passowrd_reset
    assert_equal "Passowrd reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
