require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  
  test "it is created with valid attributes" do
    restaurant = Restaurant.new(:name => "Ben's BBQ", :description => "Yummy ribs!")
    assert restaurant.valid?
  end

  test "it validates the presence of name" do
    restaurant = Restaurant.new(:name => "ABC")
    assert_equal "ABC", restaurant.name

    restaurant2 = Restaurant.new(:name => nil)
    refute restaurant2.valid? 
  end

  test "it validates the presence of description" do
    restaurant = Restaurant.new(:name => "Benjamin", :description => "Lorem Ipsum")
    assert_equal "Lorem Ipsum", restaurant.description

    restaurant2 = Restaurant.new(:name => "Benjamin")
    refute restaurant2.valid? 
  end

  test "it has categories" do
    restaurant = Restaurant.new(:name => "Benjamin", :description => "Lorem Ipsum")
    category = Category.new(:restaurant_id => restaurant.id)
    refute_equal 0, restaurant.categories.length
  end

  test "it has items" do
    restaurant = Restaurant.new(:name => "Benjamin", :description => "Lorem Ipsum")
    category = Item.new(:restaurant_id => restaurant.id)
    refute_equal 0, restaurant.items.length
  end

end
