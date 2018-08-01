module Config
  module Drivers
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
          raise UnsupportedOSError
            .new(OS.host_os, 'Your operating system is not supported')
        end
      end

      def initialize(web_app, browser)
        if !web_app.is_a?(Config::App.class)
          raise BadAppConfigError(web_app, 'Invalid web application configuration')
        end
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
        if browser_valid? 
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
          raise UnknownBrowserError
            .new(browser, 'Browser specified is not supported')
        end
      end
    end
  end
end
