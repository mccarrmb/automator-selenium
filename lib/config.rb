require 'selenium-webdriver'
require 'os'
require 'pry'
require_relative 'local.rb'
require_relative 'remote.rb'
require_relative 'app.rb'

module Config
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
end
