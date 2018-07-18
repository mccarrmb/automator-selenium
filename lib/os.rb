module OS 
  # Turns out that there isn't a standard/safe way to 
  # determine the OS in Ruby, so this will have to do.

  def self.is_macos?
    ((/darwin/ =~ RUBY_PLATFORM) == nil) ? false : true
  end

  def self.is_linux?
    ((/linux/ =~ RUBY_PLATFORM) == nil) ? false : true
  end

end