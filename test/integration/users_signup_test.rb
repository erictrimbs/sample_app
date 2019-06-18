require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    @invalid_user = { name:  "",
      email:                 "user@invalid",
      password:              "foo",
      password_confirmation: "bar" }
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: @invalid_user }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "error messages shoule be correct" do
    user = User.new(@invalid_user)
    assert_not user.valid?
    errors = user.errors.messages
    assert errors[:name].length == 1
    assert errors[:email].length == 1
    assert errors[:password].length == 1
    assert errors[:password_confirmation].length == 1
    assert errors.length == 4
  end 

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end

    assert !!flash[:success]
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

end
