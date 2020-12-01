# frozen_string_literal: true

require 'environment_utilities'
require 'page-object'
require 'selenium-webdriver'

# Default page class for all page objects
# Handles global setups and teardowns if those are needed
class PageObjectBase
  include PageObject

  def setup; end

  def teardown; end
end
