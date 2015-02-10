require 'nytimes_bestsellers/client'
require 'nytimes_bestsellers/configuration'

module Bestsellers
  class << self
    # Call this method to modify defaults in your initializers.
    #
    # @example
    #   Bestsellers.configure do |config|
    #     config.api_key = '1234567890abcdef'
    #     config.secure  = false
    #   end
    def configure(silent = false)
      yield(configuration)
      self.sender
    end

    # The configuration object.
    # @see Bestseller.configure
    def configuration
      @configuration ||= Configuration.new
    end

    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
