require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "it is created with valid attributes" do
    assert categories(:one).valid?
  end

  test "it_validates_its_attributes" do
    category = Category.new
    assert category.invalid?
  end

  test "it has items" do
    assert_includes categories(:one).items, items(:one)
  end

  test "it belongs to a restaurant" do 
    assert_equal restaurants(:one), categories(:one).restaurant
  end

end
