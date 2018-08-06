require 'selenium-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'minitest/hell'
require 'selenium_environment.rb'
require 'web_application.rb'
require 'local_driver.rb'

# Main test class for setting up config and creating drivers
class GoogleTest < Minitest::Test
  include SeleniumEnvironment
  def setup
    @google = WebApplication.new('google.com', 'https', false, false)
    chrome_driver = LocalDriver.new(@google, :chrome)
    @browser = chrome_driver.start
  end

  def teardown
    !@browser.nil? ? @browser.quit : false
  end
end
