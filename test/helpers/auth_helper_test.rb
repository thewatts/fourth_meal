require 'test_helper'

class AuthHelperTest < ActionView::TestCase  
  attr_reader :current_user, :current_restaurant

  def setup
    @current_user = users(:one)
    @current_restaurant = restaurants(:two)
  end

  def redirect_to(*args)
    false
  end

  test "super_access returns true if user is super" do
    assert users(:one).superman?
    assert super_access
    users(:one).update(:super => false)
    refute users(:one).superman?
  end

  test "owner_access returns true if user is owner" do
    @current_user = users(:three)
    assert restaurants(:two).is_owner?(users(:three))
    assert owner_access
    restaurant_users(:three).update(role: "employee")
    refute owner_access
  end

  test "employee_access returns true if user is employee" do
    assert restaurants(:two).is_employee?(users(:two))
    @current_user = users(:two)
    assert employee_access
    restaurant_users(:two).update(role: "owner")
    refute employee_access
  end

end
