require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  test "it is created with valid attributes" do
    assert items(:one).valid?
  end

  test "it_validates_its_attributes" do
    item = Item.new
    item.save
    assert item.invalid?
  end

  test "it_validates_description" do
    item = items(:one)
    item.update(:description => nil)
    assert item.invalid?
  end

  test "it_validates_price" do
    item = items(:one)
    item.update(:price => nil)
    assert item.invalid?
  end

  test "its_price_must_be_greater_than_zero" do
    item = items(:one)
    item.update(:price => -1)
    assert item.invalid?
  end

  test "it has categories" do
    assert_equal categories(:one), items(:one).categories.first
  end

  test "it has a slug" do
    assert items(:one).slug
  end

  test "it has a retired flag" do
    assert_respond_to items(:one), :retired
    refute items(:one).retired
  end

  test "it has photo attributes" do
    assert_respond_to items(:one), :photo_file_name
    assert_respond_to items(:one), :photo_content_type
    assert_respond_to items(:one), :photo_file_size
  end

  test "it belongs to a restaurant" do 
    assert_equal restaurants(:one), items(:one).restaurant
  end

end
