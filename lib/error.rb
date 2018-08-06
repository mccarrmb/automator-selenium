module Config
  module Error
    # Custom exception for bad browser symbols
    class UnknownBrowserError < StandardError
      attr_reader :object
      def initialize(object)
        @object = object
      end
    end

    # Custom exception for bad/unsupported OS symbols
    class UnsupportedOSError < StandardError
      attr_reader :object
      def initialize(object)
        @object = object
      end
    end

    # Custom exception for bad os/browser combinations
    class BadOSAndBrowserError < StandardError
      attr_reader :object
      def initialize(object)
        @object = object
      end
    end
  end
end
