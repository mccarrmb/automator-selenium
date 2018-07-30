require 'selenium-webdriver'
require 'os'
require 'pry'

module Config
  module Drivers
    # Stores all relative paths for the repo's drivers by OS
    LOCAL_DRIVERS = {
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

    # Custom exception for bad browser symbols
    class UnknownBrowserError < StandardError
      attr_reader :object
      def initialize(object)
        @object = object
      end
    end

    # Custom exception for bad/unsupported OS symbols
    class UnsupportedOSError < StandardError
      attr_reader :object
      def initialize(object)
        @object = object
      end
    end

    # Custom exception for bad os/browser combinations
    class BadOSAndBrowserError < StandardError
      attr_reader :object
      def initialize(object)
        @object = object
      end
    end

    # Class for setting up local execution
    class Local
      include Selenium
      attr_reader :browser

      # Verifies if the browser and platform comination is valid
      def browser_valid?
        !LOCAL_DRIVERS[self.class.actual_os][@browser].nil?
      end

      # Utilize OS gem to better detect host OS
      def self.actual_os
        if OS.windows? || OS::Underlying.windows?
          :windows
        elsif OS.mac? || OS::Underlying.bsd?
          :macos
        elsif OS.linux? || OS::Underlying.linux?
          :linux
        else 
          raise UnsupportedOSError.new(OS.host_os, "Your operating system is not supported")
        end
      end

      def initialize(browser)
        # Make sure all of these files are executable
        LOCAL_DRIVERS.each do |_os, apps|
          apps.each do |_app, path|
            File.chmod(0o755, path) unless File.executable?(path)
          end
        end

        # Set up Selenium logs
        log_directory = File.join(__dir__, '..', 'log')
        Dir.mkdir(log_directory) unless File.exist?(log_directory)
        WebDriver.logger.level = :debug
        WebDriver.logger.output = File.join(__dir__, '..', 'log', 'selenium.log')
        @browser = browser
      end

      def start
        unless !browser_valid? 
          WebDriver::Firefox.driver_path = LOCAL_DRIVERS[self.class.actual_os][:firefox]
          WebDriver::Chrome.driver_path = LOCAL_DRIVERS[self.class.actual_os][:chrome]
          if self.class.actual_os == :macos
            WebDriver::Safari.driver_path = LOCAL_DRIVERS[:macos][:safari]
            WebDriver.for @browser
          elsif self.class.actual_os == :windows
            WebDriver::Edge.driver_path = LOCAL_DRIVERS[:windows][:edge]
            WebDriver::IE.driver_path = LOCAL_DRIVERS[:windows][:ie]
            WebDriver.for @browser
          else
            WebDriver.for @browser
          end
        else
          raise UnknownBrowserError.new('Browser specified is not supported')
        end
      end
    end

    #Class for configuring remote execution
    class Remote
    end
  end
  
  # Class for application specific settings
  class App
    attr_reader :app_url

    def initialize(url = 'google.com', protocol = 'https')
      @app_url = protocol + '://' + url
    end
  end
end
