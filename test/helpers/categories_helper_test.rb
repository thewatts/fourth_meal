require 'test_helper'

class CategoriesHelperTest < ActionView::TestCase
  test "current category returns a category" do
    assert_nil current_category
    current_category = categories(:one)
    assert_equal categories(:one), current_category
  end

  test "link to category sets active class" do
    current_category = categories(:one)
    link_helper =  link_to_category(categories(:one), "kfc", current_category)
    expected = "<a class=\"category active\" href=\"/kfc/menu/brunch\">Brunch</a>"
    assert_equal expected, link_helper 
  end
end
