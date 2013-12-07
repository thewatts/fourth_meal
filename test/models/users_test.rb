require "test_helper"

class UsersTest < ActiveSupport::TestCase

  test "it_validates_its_attributes" do
    assert users(:one).invalid?
  end

  test "it validates email" do
    user = users(:one)
    user.update(email: nil)
    refute user.valid?
  end

 
  test "it_validates_full_name" do
    user = users(:one)
    user.update(full_name: nil)
    refute user.valid?
  end

  test "it_validates_display_name" do 
    user = users(:one)
    user.update(display_name: nil)
    refute user.valid?
  end 

  test "it can have one or more orders" do
    assert users(:one).orders.count == 2
  end
 
end
