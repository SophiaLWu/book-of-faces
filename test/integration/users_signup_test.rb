require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'registrations/new'
    assert_select "div#error_explanation"
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_difference 'User.count' do
      post users_path, params: { user: { name:  "Snoopy",
                                         email: "snoopy2@peanuts.com",
                                         password:              "peanuts",
                                         password_confirmation: "peanuts" } }
    end
    assert_template 'mailer/confirmation_instructions'
    assert_select "div#error_explanation", count: 0
  end

end