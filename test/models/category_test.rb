require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "it is created with valid attributes" do
    create_valid_category
    assert @category.valid?
  end

  test "it_validates_its_attributes" do
    category = Category.new
    category.save

    assert category.invalid?
    category.errors.full_messages.inspect 
  end

  test "it has items" do
    create_valid_category
    assert @category.items
  end

  test "it belongs to a restaurant" do 
    restaurant = Restaurant.create(:name => "Benjamin", :description => "Lorem Ipsum")
    category = create_valid_category 
    category.update(:restaurant_id => restaurant.id)
    assert category.restaurant
  end

end
