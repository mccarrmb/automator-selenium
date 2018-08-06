require 'selenium-webdriver'
require 'page-object'
require_relative '../lib/selenium_environment.rb'

# Default page class for all page objects
# Handles global setups and teardowns
class BasePage
  include PageObject

  def setup; end

  def teardown; end
end
