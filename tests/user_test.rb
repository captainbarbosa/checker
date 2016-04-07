require_relative "test_helper"
require_relative '../app/models/user'

class UserTest < Minitest::Test

  def setup
    @user = User.create(email: "bob@email.com")
  end

  def teardown
    @user.destroy
  end

  def test_user_class_exists
    assert @user
  end

  def test_user_has_email
    assert_equal "bob@email.com", @user.email
  end
end
