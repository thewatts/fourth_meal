require "test_helper"

class UsersTest < ActiveSupport::TestCase

  test "it_validates_its_attributes" do
    assert users(:one).save
  end

  test "it_invalid_email" do
    user = users(:one)
    user.update(:email => nil)
    refute user.valid?
  end

 
  test "it_validates_full_name" do
    user = users(:one)
    user.update(:full_name => nil)
    refute user.valid?
  end

  test "it_validates_display_name" do 
    user = users(:one)
    user.update(:display_name => nil)
    refute user.valid?
  end 

  test "it can have one or more orders" do
    user = users(:one)
    order1 = orders(:one)
    order2 = orders(:two)
    order1.update(:user_id => user.id)
    order2.update(:user_id => user.id)
    assert user.orders.count == 2
  end

end
