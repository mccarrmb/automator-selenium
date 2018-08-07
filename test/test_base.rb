require 'selenium-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'test_environment.rb'
require 'web_application.rb'
require 'local_driver.rb'
require 'client.rb'

# Main test class for setting up config and creating drivers
class TestBase < Minitest::Test
  def setup
    @google = WebApplication.new('google.com', 'https', false, false)
    @driver = LocalDriver.new(@google, Client::TYPE)
    @browser = @driver.instance
  end

  def teardown
    # Takes a screen shot if the 'result_code' of the test is not
    # equal to a passing value (in minitest's case, a '.' character)
    @driver.capture_window(@NAME) unless result_code.eql?('.')
    !@browser.nil? ? @browser.quit : false
  end
end
