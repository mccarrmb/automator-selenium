require 'selenium-webdriver'
require 'page-object'
require_relative '../lib/Config.rb'

# Default page class for all page objects
# Handles global setups and teardowns
class BasePage
  include PageObject

  def setup
    # TODO: add setup code
  end

  def teardown
    # TODO: add teardown code
  end
end
