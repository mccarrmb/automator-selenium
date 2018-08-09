# Class for application specific settings
class WebApplication
  attr_reader :app_url

  def initialize(url = 'google.com', protocol = 'https', mobile = false)
    @app_url = protocol + '://' + url
    @mobile = mobile
    @remote = remote
  end

  # Run the web app in mobile proportions?
  def mobile?
    @mobile
  end
end
