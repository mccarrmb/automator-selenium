require 'selenium-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'minitest/autorun'
require 'minitest/unit'

class GoogleTest < Minitest::Test

  log_directory = File.join(File.dirname(__FILE__), "..", "log")
  Dir.mkdir(log_directory) unless File.exists?(log_directory)
  Selenium::WebDriver.logger.level = :debug
  Selenium::WebDriver.logger.output = File.join(File.dirname(__FILE__), "..", "log", "selenium.log")
  Selenium::WebDriver::Firefox::Binary.path = \
    File.join(File.dirname(__FILE__), "..", "bin", "firefox", "geckodriver-v0.20.1-linux64")

  def setup
    @browser = Selenium::WebDriver.for :firefox
  end

  def teardown
    @browser.quit
  end

end
