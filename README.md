[![Build Status](https://travis-ci.org/enspencer/nytimes-bestsellers.png?branch=master)](https://travis-ci.org/enspencer/nytimes-bestsellers) [![Coverage Status](https://coveralls.io/repos/enspencer/nytimes-bestsellers/badge.png)](https://coveralls.io/r/enspencer/nytimes-bestsellers)

# New York Times Bestsellers

A Ruby gem for accessing the [New York Times Best Sellers API](http://developer.nytimes.com/docs/best_sellers_api) that gathers data from the [Best Sellers List](http://www.nytimes.com/best-sellers-books/).

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

Heads up! If you're not using Rails, note that when requiring the gem in your files you'll need to use `require nytimes_bestsellers` with the underscore rather than a dash.

## Methods

Six requests are available: get a bestseller list, get an overview of all of the best-seller lists for a given week, search a bestseller list, get the history of a single bestseller, get the names of all Times best-seller lists, and get the age group options that can be used as a parameter in the `single history` method.

### get_list(list_name, o = {})

This method has a required parameter of list name(see lists below or call the find_list_names method to find them for yourself) and takes optional parameters of date(as a string in YYYY-MM-DD format), offset, sort_by, and sort_order.

with no optional parameters it gets the most recent list
`@client.get_list('hardcover-nonfiction')`

it can take optional parameters
`@client.get_list('hardcover-nonfiction', date: '2012-04-12', offset: 20)`

### bestseller_lists_overview()

Returns an overview of Times best-seller lists for a single week. Takes an optional parameter of date in YYYY-MM-DD format. If you do not specify a date the most recent week's best-seller list will be returned.

`@client.bestseller_lists_overview`
`@client.bestseller_lists_overview(date: '2012-04-12')`


### search_list(list_name, o = {})

Allows for a filtered search of a specific list. Optional parameters are date, isbn, published_date, rank, rank_last_week, and weeks_on_list. Has additional parameters of offset, sort_by, and sort_order.

`@client.search_list('hardcover-nonfiction', published_date: "2013-04-12")`

### single_history()

Returns up to 20 weeks of history for a bestseller (its rank and number of weeks on the various Times best-seller lists). Takes one or more of the following parameters: author, contributor, isbn, price, publisher, title, age_group(see below for age group options). Has additional parameters of sort_by and sort_order.

`@client.single_history(author: 'rachel maddow')`


### find_list_names

This method takes no parameters and returns all available list names which you can use to query the get_list method. These names can be used as the required list_name parameter for get_list and single_history.

`@client.find_list_names`

### age_groups

This method takes no parameters and returns all available age groups which you can use to query the single_history method. In most cases the age group will be null, so it's not a great search method on the data. I've listen the age groups below but you can see these available age groups for yourself using the `age_groups` method.

`@client.age_groups`


## Lists

The list names to search from are:

Combined Print and E-Book Fiction, Combined Print and E-Book Nonfiction, Hardcover Fiction, Hardcover Nonfiction, Trade Fiction Paperback, Mass Market Paperback, Paperback Nonfiction, E-Book Fiction, E-Book Nonfiction, Hardcover Advice, Paperback Advice, Advice How-To and Miscellaneous, Picture Books, Chapter Books, Childrens Middle Grade, Young Adult, Paperback Books, Series Books, Hardcover Graphic Books, Paperback Graphic Books, Manga, Combined Print Fiction, Combined Print Nonfiction, Hardcover Business Books, Paperback Business Books, Business Books, Hardcover Political Books, Science Times, Dining

You can pass these names with spaces or replace spaces with hyphens, either works. The parameter is not case sensitive.

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