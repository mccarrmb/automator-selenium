require 'selenium-webdriver'
require 'os'
require 'pry'

module Config
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
  # Class used for setting webdriver options
  class Driver
    attr_reader :browser 
    attr_reader :drivers
     # Stores all relative paths for the repo's drivers
     @@drivers = {
      linux: {
        chrome: File.join(__dir__, '..', 'bin', 'chrome', \
                          'chromedriver_linux64', 'chromedriver'),
        firefox: File.join(__dir__, '..', 'bin', 'firefox', \
                           'geckodriver-v0.20.1-linux64', 'geckodriver')
      },
      macos: {
        chrome: File.join(__dir__, '..', 'bin', 'chrome', \
                          'chromedriver_mac64', 'chromedriver'),
        firefox: File.join(__dir__, '..', 'bin', 'firefox', \
                           'geckodriver-v0.20.1-macos', 'geckodriver'),
        safari: File.join('/', 'usr', 'bin', 'safaridriver')
      },
      windows: {
        chrome: File.join(__dir__, '..', 'bin', 'chrome', \
                          'chromedriver_win32', 'chromedriver.exe'),
        firefox: File.join(__dir__, '..', 'bin', 'firefox', \
                           'geckodriver-v0.20.1-win64', 'geckodriver.exe'),
        edge: File.join(__dir__, '..', 'bin', 'edge', \
                        'microsoft_webdriver_win64', \
                        'MicrosoftWebDriver.exe'),
        ie: File.join(__dir__, '..', 'bin', 'internet_explorer', \
                      'IEDriverServer_Win32_3.9.0', \
                      'IEDriverServer.exe')
      }
    }
    # Verifies if the browser and platform comination is valid
    def browser_valid?
      pp self.class.actual_os
      pp @browser
      !drivers[self.class.actual_os][@browser].nil?
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
      @@drivers.each do |_os, apps|
        apps.each do |_app, path|
          File.chmod(0o755, path) unless File.executable?(path)
        end
      end
      # Set up Selenium logs
      log_directory = File.join(__dir__, '..', 'log')
      Dir.mkdir(log_directory) unless File.exist?(log_directory)
      Selenium::WebDriver.logger.level = :debug
      Selenium::WebDriver.logger.output = File.join(__dir__, '..', 'log', 'selenium.log')

      # Firefox and Chrome have binaries for all platforms
      Selenium::WebDriver::Firefox.driver_path = @@drivers[self.class.actual_os][:firefox]
      Selenium::WebDriver::Chrome.driver_path = @@drivers[self.class.actual_os][:chrome]
      # conditional for platform dependent browsers
      if self.class.actual_os == :macos
        Selenium::WebDriver::Safari.driver_path = @@drivers[:macos][:safari]
      elsif self.class.actual_os == :windows
        Selenium::WebDriver::Edge.driver_path = @@drivers[:windows][:edge]
        Selenium::WebDriver::IE.driver_path = @@drivers[:windows][:ie]
      end

      @browser = browser
    end
  end

  # Class for building a driver for the appropriate OS/browser version
  # and binding it to the requested application
  class App
    attr_reader :app_url

    def initialize(configuration, url = 'google.com', protocol = 'https')
      @app_url = protocol + '://' + url
      
      if !configuration.is_a?(Config::Driver)
        raise TypeError.new(configuration, 'Argument is not an instance of Config::Driver')
      end

      if configuration.browser_valid?
        Selenium::WebDriver.for configuration.browser
      else
        raise UnknownBrowserError
          .new(self.browser, 'Browser specified is not supported')
      end
    end
  end
end
