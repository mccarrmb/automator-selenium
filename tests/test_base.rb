# frozen_string_literal: true

require 'csv'
require 'selenium-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'test_environment.rb'
require 'local_driver.rb'
require 'remote_driver.rb'
require 'client.rb'
require 'pry'

# Main test class for setting up config and creating drivers
class TestBase < Minitest::Test
  def setup
    pry
    require 'minitest/hell' if Client::CAPABILITIES[:parallel]
    @driver = if Client::PROPERTIES[:remote]
                RemoteDriver.new(Client::CAPABILITIES[:browser])
              else
                LocalDriver.new(Client::CAPABILITIES[:browser])
              end
    @browser = @driver.instance
    @test_data = TestEnvironment::DATA_DIR << '/'
  end

  def teardown
    # Takes a screen shot if the 'result_code' of the test is not
    # equal to a passing value (in minitest's case, a '.' character)
    @driver.capture_state(@NAME) unless result_code.eql?('.')
    !@browser.nil? ? @browser.quit : false
  end
end
