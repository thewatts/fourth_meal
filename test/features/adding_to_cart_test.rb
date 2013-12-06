require "test_helper"

class AddingToCartTest < Capybara::Rails::TestCase

  test "unauthenticated user can add items to cart" do
    create_valid_restaurant

    visit root_path
    assert page.has_content?('All Restaurants')
    click_on "KFC"

    assert_equal restaurant_root_path(@restaurant), current_path
    assert page.has_content?("Mashed Potatoes")
    within "#item_#{@item.id}" do
      click_on "Add to Cart"
    end

    assert_equal restaurant_root_path(@restaurant), current_path

    assert page.has_content?("1 Item Added to Cart")
  end
end
