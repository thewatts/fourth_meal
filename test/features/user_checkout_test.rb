require './test/test_helper'

class MenuTest < Capybara::Rails::TestCase

  def test_user_can_checkout_after_signing_up
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

    within "#new_user" do
      fill_in "Email", with: 'benji@example.com'
      fill_in "Full name", with: 'Benjamin Franklin'
      fill_in "Display name", with: 'benitobeans'
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      click_button "Create User"
    end

    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"

  end

  def test_user_can_checkout_after_signing_in
    skip
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

