# frozen_string_literal: true

class Client
  # This is the web app that will be tested. This can be modified to assist in testing various
  # app entry points and protocol support.
  @@properties = { 
                 browser: :edge,
                 parallel: false,
                 app: 'google.com',
                 protocol: 'https',
                 headless: false,
                 driver_path: File.join(__dir__, '..', '..', 'bin', 'edge', 'win64', 'msedgedriver.exe'),
                 log_file_name: 'selenium_edge.log',
                 log_level: :debug
               }

  @@capabilities = { 
                   # This controls whether Selenium constructs a driver session
                   # according to the WebDriver W3C standards or according to proprietary
                   # specs (proprietary sessions may be required for certain revisions)
                   w3c: false,
                   # Emulation contains the parameters for executing within a device emulation
                   # mode (ex. iPhoneXR, Samsung Tablet, etc.)
                   emulation: {},
                   # Loads specific Chrome extensions into the driver session
                   extensions: [],
                   options: {},
                   # Specify the BROWSER binary to use. Omitting this will default to the system's
                   # current installtion of Chrome
                   # binary:
                   # Command line arguments to pass to the ChromeDriver binary
                   args: [
                     '--screen-size=1024x768'
                   ],
                   prefs: {}
                 }
  def self.properties 
    @@properties
  end
  def self.capabilities
    @@capabilities
  end
  def self.url
    "#{@@properties[:protocol]}://#{@@properties[:app]}"
  end
end
