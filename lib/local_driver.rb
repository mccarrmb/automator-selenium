require_relative 'selenium_environment.rb'
require_relative 'web_application.rb'

# Class for setting up local execution
class LocalDriver
  include Selenium
  attr_reader :browser

  def initialize(web_app, browser)
    raise BadAppConfigError, 'Invalid web application configuration' \
      unless web_app.is_a?(WebApplication)
    # Set up Selenium logs
    log_directory = File.join(__dir__, '..', 'log')
    Dir.mkdir(log_directory) unless File.exist?(log_directory)
    WebDriver.logger.level = :debug
    WebDriver.logger.output = File.join(__dir__, '..', 'log', 'selenium.log')
    SeleniumEnvironment.prep_binaries
    SeleniumEnvironment.prep_paths
    @browser = browser
  end

  # Starts up the selected driver
  def start
    raise UnknownBrowserError, 'Browser specified is not supported' \
      unless SeleniumEnvironment.browser_host_valid?(@browser)
    WebDriver.for @browser
  end
end
