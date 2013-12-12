require './test/test_helper'

class MenuTest < Capybara::Rails::TestCase

  def setup
    @superman = User.create(full_name: "Clark Kent", display_name: "Superman", email: 'ckent@dailyplanet.com', password: 'kryptonite', password_confirmation: 'kryptonite', :super => true)
  end

  def teardown
  end

  def test_superman_views_the_admin_panel
    # Superman page is unavailable to guests
    visit superman_path
    assert_content page, "You must be logged in to do that!"

    # Superman logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'ckent@dailyplanet.com'
      fill_in "Password", with: 'kryptonite'
      click_button "Log In"
    end
    assert_content page, "Logged in"
    assert_content page, "Superman Panel"
    visit superman_path
    refute_content page, "You're not authorized to do that!"
    assert_content page, "All Restaurants In The System"
    assert_content page, "Approve"
    assert_content page, "Reject"
    assert_content page, "Administer"

    # Superman logs out and is redirected to the home page
    click_on "Log Out"
    assert_equal root_path, page.current_path
  end

  def test_superman_views_approves_and_rejects_pending_restaurants

    # Can't view a pending restaurant
    visit restaurant_root_path(restaurants(:three).id)
    assert_equal root_path, page.current_path
    assert_content page, "Sorry, this restaurant is currently offline for maintenance."

    # Superman logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'ckent@dailyplanet.com'
      fill_in "Password", with: 'kryptonite'
      click_button "Log In"
    end

    # Superman views all restaurants
    visit superman_path
    within "#tacobell_row" do
      refute_content page, "approved"
    end

    # Superman views pending restaurants
    click_on "Pending Approval"
    assert_content page, "Pending Restaurants"

    # Superman approves a restaurant
    within "#tacobell_row" do
      assert_content page, "Taco Bell"
      assert_content page, "pending"
      find("#approve_button").click
    end
    assert_content page, "Taco Bell was approved!"
    within "#tacobell_row" do
      assert_content page, "approved"
    end

    # Superman views rejected restaurants
    click_on "Rejected"
    assert_content page, "Rejected Restaurants"
    refute_content page, "Pizza Hut"

    # Superman views pending restaurants
    click_on "Pending Approval"
    assert_content page, "Pending Restaurants"

    # Superman rejects a restaurant
    within "#pizzahut_row" do
      assert_content page, "Pizza Hut"
      assert_content page, "pending"
      find("#reject_button").click
    end

    # Superman is redirected to the restaurant listing and no longer sees Pizza Hut
    assert_content page, "Pizza Hut was rejected!"
    refute page.has_css?("#pizzahut_row")

    #Superman views rejected restaurants to confirm restaurant shows up there
    click_on "Rejected"
    assert_content page, "Rejected Restaurants"
    within "#pizzahut_row" do
      assert_content page, "rejected"
    end

    # Superman logs out
    click_on "Log Out"
  end

end

