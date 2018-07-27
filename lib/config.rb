require 'selenium-webdriver'
require_relative 'os.rb'

module Config
  # Custom exception for bad browser configs
  class UnknownBrowserError < StandardError
    attr_reader :object
    def initialize(object)
      @object = object
    end
  end
  # Class used for setting webdriver options
  class Driver
    def initialize
      # Stores all relative paths for the repo's drivers
      drivers = {
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
      # Make sure all of these files are executable
      drivers.each do |_os, apps|
        apps.each do |_app, path|
          File.chmod(0o755, path) unless File.executable?(path)
        end
      end
      # Set up Selenium logs
      log_directory = File.join(__dir__, '..', 'log')
      Dir.mkdir(log_directory) unless File.exist?(log_directory)
      Selenium::WebDriver.logger.level = :debug
      Selenium::WebDriver.logger.output = File.join(__dir__, '..', 'log', \
                                                    'selenium.log')
      # Set driver paths to repo copies
      Selenium::WebDriver::Firefox.driver_path  = drivers[:macos][:firefox]
      Selenium::WebDriver::Chrome.driver_path   = drivers[:macos][:chrome]
      Selenium::WebDriver::Safari.driver_path   = drivers[:macos][:safari]
      Selenium::WebDriver::Edge.driver_path     = drivers[:windows][:edge]
      Selenium::WebDriver::IE.driver_path       = drivers[:windows][:ie]
    end
  end

  class App
    @browsers = %i[chrome
                   firefox
                   edge
                   safari
                   internet_explorer
                   remote
                   html_unit]

    attr_reader :browser
    attr_reader :app_url

    def initialize(url = 'google.com', protocol = 'https', browser = :firefox)
      @app_url = protocol + '://' + url
      if @browsers.include?(browser)
        @browser = browser
      else
        raise UnknownBrowserError
          .new(self.browser, 'Browser specified is not supported')
      end
    end
  end
end
