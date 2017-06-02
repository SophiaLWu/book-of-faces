require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Sam Hartell", email: "sam@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

  test "associated comments should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    @user.posts.first.comments.create!(content: "Lorem ipsum galgusgn", 
                                       user_id: @user.id)
    assert_difference 'Comment.count', -1 do
      @user.destroy
    end
  end

  test "associated likes should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    @user.posts.first.likes.create!(user_id: @user.id)
    assert_difference 'Like.count', -1 do
      @user.destroy
    end
  end

  test "can friend another user" do
    pigpen = users(:pigpen)
    violet = users(:violet)
    assert_empty(pigpen.requested_friends)
    assert_empty(violet.pending_friends)
    friendship = pigpen.requested_friendships.build(friended_id: violet.id)
    friendship.save
    assert_not_empty(violet.pending_friends)
    assert_not_empty(pigpen.requested_friends)
    assert pigpen.friended(violet)
  end

  test "can accept a user's friend request" do
    pigpen = users(:pigpen)
    violet = users(:violet)
    friendship = pigpen.requested_friendships.build(friended_id: violet.id)
    friendship.save
    assert_empty(pigpen.friends)
    assert_empty(violet.friends)
    friendship.accept_friend_request
    assert_not_empty(pigpen.friends)
    assert_not_empty(violet.friends)
    assert pigpen.is_friend?(violet)
    assert violet.is_friend?(pigpen)
  end

  test "can unfriend a friend" do
    pigpen = users(:pigpen)
    violet = users(:violet)
    friendship = pigpen.requested_friendships.build(friended_id: violet.id)
    friendship.save
    friendship.accept_friend_request
    assert pigpen.is_friend?(violet)
    assert violet.is_friend?(pigpen)
    pigpen.unfriend(violet)
    assert_not pigpen.is_friend?(violet)
    assert_not violet.is_friend?(pigpen)
    assert_empty(pigpen.friends)
    assert_empty(violet.friends)
  end

end
