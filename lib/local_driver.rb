require 'date'
require 'test_environment.rb'
require 'web_application.rb'

# Class for setting up local execution
class LocalDriver
  include Selenium
  attr_reader :browser
  attr_reader :log_directory
  attr_accessor :instance

  def initialize(web_app, browser)
    raise BadAppConfigError, 'Invalid web application configuration' \
      unless web_app.is_a?(WebApplication) && browser.is_a?(Symbol)
    # Set up Selenium log behavior
    WebDriver.logger.level = :debug
    WebDriver.logger.output = File.join(TestEnvironment::LOG_DIR, 'selenium.log')
    @browser = browser
    raise UnknownBrowserError, 'Browser specified is not supported' \
      unless TestEnvironment.browser_host_valid?(@browser)
    @instance = WebDriver.for @browser
    @instance.manage.timeouts.implicit_wait = TestEnvironment::IMPLICIT_WAIT
  end

  def capture_window(test_name = '')
    @instance.save_screenshot(
      File.join(TestEnvironment::LOG_DIR, "#{test_name}_#{@browser}_#{log_time}.png")
    )
  end

  def capture_dom; end

  def log_time
    Time.now.strftime('_%Y-%m-%dT%H:%M:%S.%L')
  end
end
