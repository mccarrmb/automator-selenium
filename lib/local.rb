module Config
  module Drivers
    # Class for setting up local execution
    class Local
      include Selenium
      attr_reader :browser

      def initialize(web_app, browser)
        unless web_app.is_a?(Config::App.class)
          raise BadAppConfigError(web_app, 'Invalid web application configuration')
        end
        # Set up Selenium logs
        log_directory = File.join(__dir__, '..', 'log')
        Dir.mkdir(log_directory) unless File.exist?(log_directory)
        WebDriver.logger.level = :debug
        WebDriver.logger.output = File.join(__dir__, '..', 'log', 'selenium.log')
        @browser = browser
      end

      # Starts up the selected driver
      def start
        if browser_valid?
          WebDriver.for @browser
        else
          raise UnknownBrowserError
            .new(browser, 'Browser specified is not supported')
        end
      end
    end
  end
end
