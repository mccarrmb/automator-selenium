# frozen_string_literal: true

require 'selenium-webdriver'
require 'os'
require 'pry'

# Helper module for working with the local, relative selenium resources
module TestEnvironment
  # Stores all relative paths for the repo's drivers by OS
  WEB_DRIVERS = {
    linux: {
      chrome: File.join(__dir__, '..', 'bin', 'chrome', 'chromedriver_linux64', 'chromedriver'),
      firefox: File.join(__dir__, '..', 'bin', 'firefox', 'geckodriver-v0.20.1-linux64', 'geckodriver')
    },
    macos: {
      chrome: File.join(__dir__, '..', 'bin', 'chrome', 'chromedriver_mac64', 'chromedriver'),
      firefox: File.join(__dir__, '..', 'bin', 'firefox', 'geckodriver-v0.20.1-macos', 'geckodriver'),
      safari: File.join('/', 'usr', 'bin', 'safaridriver')
    },
    windows: {
      chrome: File.join(__dir__, '..', 'bin', 'chrome', 'chromedriver_win32', 'chromedriver.exe'),
      firefox: File.join(__dir__, '..', 'bin', 'firefox', 'geckodriver-v0.20.1-win64', 'geckodriver.exe'),
      edge: File.join(__dir__, '..', 'bin', 'edge', 'microsoft_webdriver_win64', 'MicrosoftWebDriver.exe'),
      ie: File.join(__dir__, '..', 'bin', 'internet_explorer', 'IEDriverServer_Win32_3.9.0', 'IEDriverServer.exe')
    }
  }.freeze

  IMPLICIT_WAIT = 10
  DATA_DIR = File.join(__dir__, '..', 'data')
  LOG_DIR = File.join(__dir__, '..', 'log')
  Dir.mkdir(LOG_DIR) unless File.exist?(LOG_DIR)

  # Custom exception for passing invalid config arguments
  class BadAppConfigError < StandardError
    attr_reader :message
    def initialize(message = nil)
      @message = message
    end
  end

  # Custom exception for bad browser symbols
  class UnknownBrowserError < StandardError
    attr_reader :message
    def initialize(message = nil)
      @message = message
    end
  end

  # Custom exception for bad/unsupported OS symbols
  class UnsupportedOSError < StandardError
    attr_reader :message
    def initialize(message = nil)
      @message = message
    end
  end

  # Custom exception for bad os/browser combinations
  class InvalidBrowserOSCombinationError < StandardError
    attr_reader :message
    def initialize(message = nil)
      @message = message
    end
  end

  # Utilize OS gem to better detect host OS (required for running native drivers)
  def self.actual_os
    if OS::Underlying.windows?
      :windows
    elsif OS::Underlying.bsd?
      :macos
    elsif OS::Underlying.linux?
      :linux
    else
      raise UnsupportedOSError, 'Your operating system is not supported'
    end
  end

  # Verifies if the browser and platform comination is valid
  def self.browser_host_valid?(browser)
    !WEB_DRIVERS[self.actual_os][browser].nil?
  end

  # Make sure all of these files are executable
  def self.prep_binaries
    WEB_DRIVERS.each do |_os, apps|
      apps.each do |app, path|
        if app != :safari
          File.chmod(0o755, path) unless File.executable?(path)
        end
      end
    end
  end

  # Set driver binary paths to local copies
  def self.prep_paths
    os = actual_os
    Selenium::WebDriver::Firefox::Service.driver_path = WEB_DRIVERS[os][:firefox]
    Selenium::WebDriver::Chrome::Service.driver_path = WEB_DRIVERS[os][:chrome]
    if os == :macos
      Selenium::WebDriver::Safari::Service.driver_path = WEB_DRIVERS[os][:safari]
    elsif os == :windows
      Selenium::WebDriver::Edge::Service.driver_path = WEB_DRIVERS[os][:edge]
      Selenium::WebDriver::IE::Service.driver_path = WEB_DRIVERS[os][:ie]
    end
  end

  self.prep_binaries
  self.prep_paths
end
