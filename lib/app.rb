module Config
  # Class for application specific settings
  class App
    attr_reader :app_url

    def initialize(url = 'google.com', protocol = 'https', mobile = false)
      @app_url = protocol + '://' + url
      @mobile = mobile
    end

    # Run the web app in mobile proportions?
    def mobile?
      @mobile
    end
  end
end
