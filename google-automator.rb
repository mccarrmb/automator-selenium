require 'selenium-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'minitest/autorun'
require 'minitest/unit'
require_relative 'lib/config.rb'

# Main test class for setting up config and creating drivers
class GoogleTest < Minitest::Test
  include Config
  def setup
    config = Drivers::Local.new(:firefox)
    @browser = Drivers::Local.start
  end

  def teardown
    !@browser.nil? ? @browser.quit : false
  end
end
