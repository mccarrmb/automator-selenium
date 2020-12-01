
module EnvironmentUtilities
  require 'selenium-webdriver'

  # This is the directory that contains test data that can be used to 
  # create multiple tests (.CSV, .XLSX, .ZIP, etc...)
  DATA_DIR = File.join(__dir__, '..', 'data').freeze
  
  # Contains the main Selenium log file along with test failure screenshots and DOM dumps
  LOG_DIR = File.join(__dir__, '..', 'log').freeze

  # Directory containing the screenshots for successful tests and other artifacts 
  # used to verify test success
  ARTIFACT_DIR = File.join(__dir__, '..', 'artifacts').freeze

  Dir.mkdir(LOG_DIR) unless File.exist?(LOG_DIR)
  Dir.mkdir(ARTIFACT_DIR) unless File.exist?(ARTIFACT_DIR)

  # Custom exception for passing invalid config arguments
  class BadAppConfigError < StandardError
    def initialize(message)
      super(message)
    end
  end

  # Custom exception for bad browser symbols
  class UnknownBrowserError < StandardError
    def initialize(message)
      super(message)
    end
  end

  # Custom exception for bad/unsupported OS symbols
  class UnsupportedOSError < StandardError
    def initialize(message)
      super(message)
    end
  end

  # Custom exception for bad os/browser combinations
  class InvalidBrowserOSCombinationError < StandardError
    def initialize(message)
      super(message)
    end
  end

  class OSCheck
    require 'os'
    require 'pp'

    # This code supports macOS, Linux, and Windows.
    OS_BROWSER_SUPPORT = {
      windows: [:chrome, :edge, :firefox],
      macos: [:chrome, :edge, :firefox, :safari],
      linux: [:chrome, :firefox] # Edge support for Linux is currently untested
    }.freeze

    # Utilize OS gem to better detect host OS (required for running native drivers)
    # This is extremely important in the case where this code is executed in specialized
    # environments. This includes Windows Subsystem for Linux, CygWin, MinGW, Wine or any other
    # compatability layer that provides the system with an ability to execute multiple types
    # of OS binaries.
    def self.actual_os
      if OS::Underlying.windows?
        :windows
      elsif OS::Underlying.bsd?
        :macos
      elsif OS::Underlying.linux?
        :linux
      else
        raise UnsupportedOSError, 'Your operating system is not supported.'
      end
    end

    # Verifies if the browser and platform combination is valid
    def self.browser_host_valid?(browser)
      OS_BROWSER_SUPPORT[actual_os].include?(browser)
    end
  end

  class TestHelpers
    # Similar to capture state, except this only captures a screenshot of the positive outcome
    def self.capture_artifact(driver, test_name = '')
      file_name = File.join(EnvironmentUtilities::ARTIFACT_DIR, "artifact-#{test_name}_#{@browser}_#{log_time}")
      driver.save_screenshot("#{file_name}.png")
    end

    # Captures a screenshot and dumps the current DOM state
    def self.capture_state(driver, test_name = '')
      file_name = File.join(EnvironmentUtilities::LOG_DIR, "#{test_name}_#{@browser}_#{log_time}")
      driver.save_screenshot("#{file_name}.png")
      dom_file = File.new("#{file_name}.dom", 'w+')
      dom_file.puts(
        driver.execute_script('return document.documentElement.outerHTML'),
      )
    end

    # Helper to get a formatted timestamp string for logging purposes
    def self.log_time
      Time.now.strftime('_%Y-%m-%dT%H-%M-%S.%L')
    end
  end
end
