require 'selenium-webdriver'
require 'page-object'
require 'test_environment.rb'

# Default page class for all page objects
# Handles global setups and teardowns
class BasePage
  include PageObject

  def setup; end

  def teardown; end
end
