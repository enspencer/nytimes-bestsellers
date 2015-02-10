module Bestsellers
  class Configuration
    attr_accessor :api_key

    attr_accessor :lists_url

    def initialize
      @api_key = nil
      @lists_url = 'http://api.nytimes.com/svc/books/v3/lists'
    end

    # Allows config options to be read like a hash
    #
    # @param [Symbol] option Key for a given attribute
    def [](option)
      send(option)
    end
 
    # Returns a hash of all configurable options
    def to_hash
      OPTIONS.inject({}) do |hash, option|
        hash[option.to_sym] = self.send(option)
        hash
      end
    end
  end
end
