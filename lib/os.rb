module OS 
  # Turns out that there isn't a standard way to determine the OS in Ruby
  
  def is_macos?
    if ((/darwin/ =~ RUBY_PLATFORM) == nil)
      return false
    else
      return true
    end
  end

  def is_linux?
    if ((/linux/ =~ RUBY_PLATFORM) == nil)
      return false
    else
      return true
    end
  end

end