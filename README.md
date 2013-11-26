# New York Times Bestsellers

This is a Ruby wrapper for the [NYTimes Bestsellers API](http://developer.nytimes.com/docs/best_sellers_api).

## Install

Add this line to your application's Gemfile:

    gem 'nytimes-bestsellers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nytimes-bestsellers

## Getting Started

You'll want to sign up for an [API key](http://developer.nytimes.com/apps/register) to start.

Setup a new instance:

```ruby
@client = Bestsellers.new
@client.configure do |config|  
  config.api_key = "YOUR_API_KEY"
end
```

## Methods

Five requests are available: get a best-seller list, search best-seller lists, get the history of a best seller, get an overview of all of the best-seller lists for a given week and get the names of Times best-seller lists.

1. get_list(list_name, o = {})

This method has a required parameter of list name(see lists below or call the find_list_names method to find them for yourself) and takes an optional parameter of date, as a string in YYYY-MM-DD format. It also takes an optional parameter of response format and if none is specified it defaults to json.

with no optional parameters it gets the most recent list
`@client.get_list('hardcover-nonfiction')`

it can take optional parameters
`@client.get_list('hardcover-nonfiction', date: '2012-04-12', response: 'xml')`

2. bestseller_lists_overview()

returns an overview of Times best-seller lists given a week in YYYY-MM-DD form
`@client.bestseller_lists_overview('2012-04-12')`

3. search_list(list_name, o = {})

4. single_history

5. find_list_names

This method takes no parameters and returns all available list names which you can use to query the get_list method.

6. age_groups

This method takes no parameters and returns all available age groups which you can use to query the single_history method. In most cases the age group will be null, so it's not a great search method on the data. I've listen the age groups below but you can see these available age groups for yourself using the `age_groups` method.


## Lists

The list names to search from are:

Combined Print and E-Book Fiction, Combined Print and E-Book Nonfiction, Hardcover Fiction, Hardcover Nonfiction, Trade Fiction Paperback, Mass Market Paperback, Paperback Nonfiction, E-Book Fiction, E-Book Nonfiction, Hardcover Advice, Paperback Advice, Advice How-To and Miscellaneous, Picture Books, Chapter Books, Childrens Middle Grade, Young Adult, Paperback Books, Series Books, Hardcover Graphic Books, Paperback Graphic Books, Manga, Combined Print Fiction, Combined Print Nonfiction, Hardcover Business Books, Paperback Business Books, Business Books, Hardcover Political Books, Science Times, Dining

When passing these names as paraemeters replace spaces with hyphens. The parameter is not case sensitive.

## Age Groups

The age group parameter can be used as an optional parameter in the `single_history` method. In most cases the age group will be null, so it's not a great search method on the data. But you can use the age groups below to search, or see these available age groups for yourself using the `age_groups` method.

Valid age groups: "Ages 1 to 5", "Ages 10 and up", "Ages 10 to 13", "Ages 10 to 14", "Ages 10 to 15", "Ages 10 to 18", "Ages 11 and up", "Ages 11 to 14", "Ages 11 to 15", "Ages 12 and  up", "Ages 12 and up", "Ages 12 to 14", "Ages 12 to 17", "Ages 12 to 18", "Ages 13 and up", "Ages 13 to 16", "Ages 13 to 17", "Ages 13 to 18", "Ages 14 and up", "Ages 14 to 17", "Ages 14 to 18", "Ages 15 and up", "Ages 15 to 17", "Ages 15 to 18", "Ages 16 and up", "Ages 17 and up", "Ages 18 and up", "Ages 2 and up", "Ages 2 to 5", "Ages 2 to 6", "Ages 2 to 7", "Ages 3 and up", "Ages 3 to 5", "Ages 3 to 6", "Ages 3 to 7", "Ages 3 to 8, "Ages 4 and up", "Ages 4 to 7", "Ages 4 to 8", "Ages 5 and up", "Ages 5 to 10"}, "Ages 5 to 7", "Ages 5 to 8", "Ages 5 to 9", "Ages 6 and up", "Ages 6 to 10"}, "Ages 6 to 12"}, "Ages 6 to 14", "Ages 6 to 8", "Ages 6 to 9", "Ages 7 and up", "Ages 7 to 10", "Ages 7 to 12", "Ages 7 to 17", "Ages 7 to 9", "Ages 8 and up", "Ages 8 to 12", "Ages 8 to 14", "Ages 9 and up", "Ages 9 to 11", "Ages 9 to 12", "Ages 9 to 13", "All ages"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature`)
3. Commit your changes (`git commit -m 'Add this feature'`)
4. Push to the branch (`git push origin feature`)
5. Create new Pull Request

## License

Copyright © 2013 Emma Spencer. See LICENSE.txt for further details.