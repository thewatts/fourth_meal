require 'test_helper'

class ItemCategoryTest < ActiveSupport::TestCase
  
  test "it is created with valid attributes" do
    assert item_categories(:one).valid?
  end

  test "it_validates_item_id" do
    item_category = item_categories(:one)
    item_category.update(:item_id => nil)
    refute item_category.valid?
  end

  test "it_validates_category_id" do
    item_category = item_categories(:one)
    item_category.update(:category_id => nil)
    refute item_category.valid?
  end

end
