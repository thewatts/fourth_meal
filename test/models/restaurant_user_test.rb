require 'test_helper'

class RestaurantUserTest < ActiveSupport::TestCase

  test "it is created with valid attributes" do
    assert restaurant_users(:one).valid?
  end

  test "it validates restaurant_id" do
    restaurant_user = restaurant_users(:one)
    restaurant_user.update(:restaurant_id => nil)
    refute restaurant_user.valid?
  end

  test "it validates user_id" do
    restaurant_user = restaurant_users(:one)
    restaurant_user.update(:user_id => nil)
    refute restaurant_user.valid?
  end

  test "a user has a role for a particular restaurant" do
    user = users(:one)
    assert_equal "employee", user.restaurant_users.first.role
  end

  test "a user's role is customer by default" do
    user = users(:two)
    assert_equal "customer", user.restaurant_users.first.role
    assert_equal "owner", user.restaurant_users.last.role
  end

  test "a user can only have one of three roles" do 
    restaurant_user = RestaurantUser.new(user: users(:one), 
                                         restaurant: restaurants(:one),
                                         role: "Invalid")
    refute restaurant_user.valid?
  end



end
