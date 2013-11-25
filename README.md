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

You'll want to sign up for an [API key](http://developer.nytimes.com/apps/register)

## Methods

Five requests are available: get a best-seller list, search best-seller lists, get the history of a best seller, get an overview of all of the best-seller lists for a given week and get the names of Times best-seller lists.

1. get_list(list_name, o = {})

This method has a required parameter of list name(see lists below or call the find_list_names method to find them for yourself) and takes an optional parameter of date, as a string in YYYY-MM-DD format. It also takes an optional parameter of response format and if none is specified it defaults to json.

with no optional parameters it gets the most recent list
`puts get_list('hardcover-nonfiction')`

it can take optional parameters
`puts get_list('hardcover-nonfiction', date: '2012-04-12', response: 'xml')`

2. bestseller_lists_overview()

returns an overview of Times best-seller lists given a week in YYYY-MM-DD form
`puts bestseller_lists_overview('2012-04-12')`

3. find_list_names

This method takes no


## Lists

The list names to search from are:

Combined Print and E-Book Fiction, Combined Print and E-Book Nonfiction, Hardcover Fiction, Hardcover Nonfiction, Trade Fiction Paperback, Mass Market Paperback, Paperback Nonfiction, E-Book Fiction, E-Book Nonfiction, Hardcover Advice, Paperback Advice, Advice How-To and Miscellaneous, Picture Books, Chapter Books, Childrens Middle Grade, Young Adult, Paperback Books, Series Books, Hardcover Graphic Books, Paperback Graphic Books, Manga, Combined Print Fiction, Combined Print Nonfiction, Hardcover Business Books, Paperback Business Books, Business Books, Hardcover Political Books, Science Times, Dining

When passing these names as paraemeters replace spaces with hyphens. The parameter is not case sensitive.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature`)
3. Commit your changes (`git commit -m 'Add this feature'`)
4. Push to the branch (`git push origin feature`)
5. Create new Pull Request