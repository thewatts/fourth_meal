ENV["RAILS_ENV"] ||= "test"
# require 'simplecov'
# SimpleCov.start 'rails'
# puts "required simplecov"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'
# require './test/helpers/minitest_helper'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include Capybara::DSL
  include Capybara::Assertions
  include Rails.application.routes.url_helpers


  def create_valid_item
    @item = Item.create(:title => "Hello!",
                        :description => "World",
                        :price => 4,
                        :slug => "new_item",
                        :retired => false,
                        :photo_file_name => "hello.jpg",
                        :photo_content_type => "jpeg",
                        :photo_file_size => 12353,
                        :photo_updated_at => Time.now.to_s,
                        :restaurant_id => 1)
  end

  def create_valid_order
    @order = Order.create(:status => 'unpaid', :user_id => 5)
  end

  def create_valid_category
    @category = Category.create(:title => 'Brunch', :restaurant_id => 1)
  end

  def create_valid_user(password = "password")
    @user = User.create(:email        => "test@example.com",
                        :full_name    => "Bennny Smith",
                        :display_name => "Bennybeans",
                        :password     => password)
  end

  def create_valid_restaurant
    @restaurant = Restaurant.create(:name => "KFC",
      :description => "Kentucky Fried Wonder")
  end

  # Add more helper methods to be used by all tests here...
end
