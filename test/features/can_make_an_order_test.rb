require './test/test_helper'


class CanMakeAnOrderTest < Capybara::Rails::TestCase

  test "a user can create an order" do
    create_valid_restaurant

    visit root_path
    click_on "KFC"

    within "#item_#{@item.id}" do
      click_on "Add to Cart"
    end

    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"
    
  end

  

  test "can add multiple items to order without logging in" do
    create_valid_restaurant
    @item2 = Item.create(:title => "Chicken Drumsticks",
                            :description => "World",
                            :price => 4,
                            :slug => "new_item",
                            :retired => false,
                            :photo_file_name => "hello.jpg",
                            :photo_content_type => "jpeg",
                            :photo_file_size => 12353,
                            :photo_updated_at => Time.now.to_s,
                            :restaurant_id => @restaurant.id)

    visit root_path
    click_on "KFC"

    within "#item_#{@item.id}" do
      click_on "Add to Cart"
    end

    within "#item_#{@item2.id}" do
      click_on "Add to Cart"
    end

    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"
    assert_content page, "Chicken Drumsticks"
  end

  test "can add multiple instances of same item to order" do
    create_valid_restaurant
    visit root_path
    click_on "KFC"

    within "#item_#{@item.id}" do
      click_on "Add to Cart"
    end

    within "#item_#{@item.id}" do
      click_on "Add to Cart"
    end

    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"
    within("#current_order") do
      assert_content page, "2"
    end
  end

end
