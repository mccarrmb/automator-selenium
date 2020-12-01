# frozen_string_literal: true

require 'client'
require 'csv'
require 'driver_factory'
require 'environment_utilities'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'page-object'
require 'page-object/page_factory'
require 'pry'
require 'selenium-webdriver'

# Main test class for setting up test parameters and creating drivers
class TestBase < Minitest::Test
  include EnvironmentUtilities

  def setup
    # Minitest's Hell library enables purely parallel test execution
    require 'minitest/hell' if Client.properties[:parallel]
    # The DriverFactory sets up the execution environment as well as the actual WebDriver
    @browser = Drivers::DriverFactory.build(Client.properties, Client.capabilities)
    # Convenience attribute to help dynamically create tests from data files
    @test_data = File.join(DATA_DIR, '/')
  end
  
  def teardown
    # Takes a screen shot if the 'result_code' of the test is equal to a
    # passing value (in minitest's case, a '.' character). If the test failed
    # (E or F), it takes a screen shot AND creates a dump of the active DOM
    # at the time of the failure - very helpful for narrowing down AJAX-y bugs.
    result_code.eql?('.') ? TestHelpers.capture_artifact(@browser, @NAME) : \
      TestHelpers.capture_state(@browser, @NAME)
    !@browser.nil? ? @browser.quit : false
  end
end
