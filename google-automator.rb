require 'selenium-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'minitest/autorun'
require 'minitest/unit'
require_relative 'lib/os.rb'
require_relative 'lib/config.rb'

# Main test class for setting up config and creating drivers
class GoogleTest < Minitest::Test
  def setup
    @browser = Config.App.new(Config::Driver.new(:firefox), 'google.com', 'https')
  end

  def teardown
    !@browser.nil? ? @browser.quit : false
  end
end
