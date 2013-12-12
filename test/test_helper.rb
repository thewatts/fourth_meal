ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'
# require './test/helpers/minitest_helper'



class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include Capybara::DSL
  include Capybara::Assertions
  include Rails.application.routes.url_helpers

  fixtures :all

end
