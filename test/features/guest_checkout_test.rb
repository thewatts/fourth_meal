require './test/test_helper'

class MenuTest < Capybara::Rails::TestCase

  def test_guest_can_checkout_without_signing_up
    visit root_path
    click_on "KFC"

    within "#item_#{items(:two).id}" do
      click_on "Add to Cart"
    end

    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"
    click_on "Checkout"

    assert_content page, "Sign Up"
    assert_content page, "Log In"
    assert_content page, "Checkout As A Guest"

  end

end

