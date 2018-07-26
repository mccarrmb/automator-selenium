require 'selenium-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'minitest/autorun'
require 'minitest/unit'
require_relative 'lib/os.rb'
require_relative 'lib/config.rb'

# Main test class for setting up config and creating drivers
class GoogleTest < Minitest::Test
  # Sets up Selenium logging 
  log_directory = File.join(File.dirname(__FILE__), 'log')
  Dir.mkdir(log_directory) unless File.exist?(log_directory)
  Selenium::WebDriver.logger.level = :debug
  Selenium::WebDriver.logger.output = File.join(\
    File.dirname(__FILE__), 'log', 'selenium.log'
  )

  @drivers = []

  def setup
    @drivers.each do |driver|
      @browser = driver
    end 
    @browser
  end

  def teardown
    !@browser.nil? ? @browser.quit : false
  end

  # select_drivers with no arguments will select all 
  # drivers available for the host OS
  def select_drivers

    opts = Selenium::WebDriver::Firefox::Options.new
    opts.headless!
    @browser = Selenium::WebDriver.for :firefox
  end
end
