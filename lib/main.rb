require 'httparty'
require 'pry'
require 'dotenv'


Dotenv.load "../.env"


def find_list_names
  HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/names?api-key=#{ENV['API_KEY']}")
end

def get_list(list_name, o = {})
  date = o[:date]
  response_format = o[:response] || 'xml'
  # offset =
  # sort-by = 
  # sort-order = 
  # response-format =
  HTTParty.get("http://api.nytimes.com/svc/books/v2/lists.#{response_format}/#{date}/#{list_name}?&api-key=#{ENV['API_KEY']}")
end

def bestseller_lists_overview(date, o = {})
  response_format = o[:response] || 'json'
  HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/overview.#{response_format}?published_date=#{date}&api-key=#{ENV['API_KEY']}")
end

def search_lists
  HTTParty.get("http://api.nytimes.com/svc/books/v2/lists[.response_format]?{search-param1=value1}&[...]&[optional-param1=value1]&[...]&api-key=#{ENV['API_KEY']}")
end

def single_history
  HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/best-sellers/history[.response_format]?{search-param1=value1}&[...]&[optional-param1=value1]&[...]&api-key=#{ENV['API_KEY']}")
end


# with no optional parameters it gets the most recent list
# puts get_list('hardcover-nonfiction')

# it can take optional parameters
# puts get_list('hardcover-nonfiction', date: '2012-04-12')

# returns an overview of Times best-seller lists given a week in YYYY-MM-DD form
puts bestseller_lists_overview('2012-04-12', response: 'xml')