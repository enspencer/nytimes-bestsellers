require_relative 'nytimes_bestsellers/client'
require 'pry'
require 'dotenv'

Dotenv.load "../.env"

# client = Bestsellers.configure {|config| config.api_key = "foo"}
# client.get_list
module Bestsellers
  class << self

    def new
      @list ||= Bestsellers::List.new
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

list = Bestsellers.configure do |config|  
  config.api_key = "ENV['API_KEY']"
end

binding.pry

list.get_list('hardcover-fiction')