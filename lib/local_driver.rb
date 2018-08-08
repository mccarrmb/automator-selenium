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

  def capture_state(test_name = '')
    file_name = File.join(TestEnvironment::LOG_DIR, "#{test_name}_#{@browser}_#{log_time}")
    @instance.save_screenshot("#{file_name}.png")
    dom_file = File.new("#{file_name}.dom", 'w+')
    dom_file.puts(
      @instance.execute_script('return document.documentElement.outerHTML')
    )
  end

  def log_time
    Time.now.strftime('_%Y-%m-%dT%H:%M:%S.%L')
  end
end
