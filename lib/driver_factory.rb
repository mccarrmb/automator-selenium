# frozen_string_literal: true

module Drivers
  require 'client'
  require 'date'
  require 'environment_utilities'
  require 'json'
  require 'pry'

  class DriverFactory
    include Selenium
    include EnvironmentUtilities

    # Automatically creates a driver for our test cases according to the Client configuration.
    # This helps to keep our test files driver-agnostic.
    def self.build(client_properties, client_capabilities)
      # Sanity check in case the client.rb is not configured correctly
      raise InvalidBrowserOSCombinationError unless OSCheck.browser_host_valid?(client_properties[:browser])

      case client_properties[:browser]
        when :chrome
          configure_chrome(client_properties, client_capabilities)
        when :edge
          configure_edge(client_properties, client_capabilities)
        when :firefox
          configure_firefox(client_properties, client_capabilities)
        when :safari
          configure_safari(client_properties, client_capabilities)
        when :remote
          configure_remote(client_properties, client_capabilities)
        else
          raise UnknownBrowserError, 'Cannot configure driver capabilities for an unrecognized driver.'
      end
    end

    # Builds the Chrome driver according to the Client config
    def self.configure_chrome(properties, capabilities)
      WebDriver.logger.level = properties[:log_level]
      WebDriver.logger.output =  File.join(LOG_DIR, properties[:log_file_name])
      WebDriver::Chrome::Service.driver_path = (properties[:driver_path])
      options = WebDriver::Chrome::Options.new(capabilities)
      WebDriver.for(:chrome, options: options)
    end

    # Edge has nearly identical properties to Chrome now
    def self.configure_edge(properties, capabilities)
      WebDriver.logger.level = properties[:log_level]
      WebDriver.logger.output =  File.join(LOG_DIR, properties[:log_file_name])
      WebDriver::Edge::Service.driver_path = (properties[:driver_path])
      options = WebDriver::Chrome::Options.new(capabilities)
      binding.pry
      WebDriver.for(:edge, options: options)
    end

    # TODO: add firefox support
    def self.configure_firefox(properties, capabilities)
    end

    # TODO: add safari support
    def self.configure_safari(properties, capabilities)
    end
  end
end
