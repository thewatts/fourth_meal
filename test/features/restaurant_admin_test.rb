require './test/test_helper'

class RestaurantAdminTest < Capybara::Rails::TestCase

  def setup
    @admin = User.create(full_name: "Joan of Arc", display_name: "Joan A.", email: 'jarc@thestake.fr', password: 'martyr', password_confirmation: 'martyr')
  end

  def teardown
  end

  def test_admin_views_the_admin_panel
    # Admin page is unavailable to guests
    visit admin_path(restaurants(:one))
    assert_content page, "You must be logged in to do that!"

    # Admin logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'jarc@thestake.fr'
      fill_in "Password", with: 'martyr'
      click_button "Log In"
    end
    assert_content page, "Logged in"
    visit restaurant_root_path(restaurants(:one))
    refute_content page, "You're not authorized to do that!"
    
    # Admin logs out and is redirected to the home page
    click_on "Log out"
    assert_equal root_path, page.current_path
  end

end

