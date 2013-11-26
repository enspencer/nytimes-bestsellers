require 'json'
require 'httparty'
require 'pry'
require_relative 'configuration'

module Bestsellers

  class List
    include Bestsellers::Configuration
    include HTTParty

    def initialize
      reset
    end

    def self.get_list(list_name, o = {})
      # enter a list, optional: enter offset, sort_by, sort_order, response_format
      if o[:date]
        date = o[:date]
      end

      if o[:offset]
        offset = o[:offset].to_s
      end

      if o[:sort_by]
        # options are: bestsellers-date | date | isbn | list | list-name | published-date rank | rank-last-week | weeks-on-list
        sort_by = o[:sort_by]
      end

      if o[:sort_order] 
        # can be ASC OR DESC
        sort_order = o[:sort_order]
      end

      if o[:response_format]
        response_format = '.' + o[:response_format]
      end

      HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/#{date}/#{list_name}#{response_format}?&offset=#{offset}&sort-order=#{sort_order}&api-key=#{ENV['API_KEY']}")
    end

    def self.search_list(list_name, o = {})

      url = "http://api.nytimes.com/svc/books/v2/lists?list-name=#{list_name}"

      # search a list by list_name, optional: bestsellers-date, date, isbn, published-date, rank, rank-last-week, weeks-on-list
      if o[:bestsellers_date]
        bestsellers_date = o[:bestsellers_date]
        url << "&bestsellers-date=#{bestsellers_date}"
      end


      date = (o[:date] || Date.today).strftime('%Y-%m-%e')
      url << "&date=#{date}"

      if o[:isbn]
        isbn = o[:isbn]
        url << "&isbn=#{isbn}"
      end

      if o[:published_date]
        published_date = o[:published_date]
        url << "&published-date=#{published_date}"
      end

      if o[:rank]
        rank = o[:rank]
        url << "&rank=#{rank}"
      end

      if o[:rank_last_week]
        rank_last_week = o[:rank_last_week]
        url << "&rank-last-week=#{rank_last_week}"
      end

      if o[:weeks_on_list]
        weeks_on_list = o[:weeks_on_list]
        url << "&weeks-on-list=#{weeks_on_list}"
      end

      if o[:response_format]
        response_format = '.' + o[:response_format]
      end

      url << "&api-key=#{ENV['API_KEY']}"

      # HTTParty.get("http://api.nytimes.com/svc/books/v2/lists#{response_format}?list-name=#{list_name}&bestsellers-date=#{bestsellers_date}&date=#{date}&isbn=#{isbn}&published-date=#{published_date}&rank=#{rank}&rank-last-week=#{rank_last_week}&weeks-on-list=#{weeks_on_list}&api-key=#{ENV['API_KEY']}")
      HTTParty.get(url)
    end

    def self.bestseller_lists_overview(date, o = {})
      if o[:date]
        date = o[:date]
      end

      HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/overview?published_date=#{date}&api-key=#{ENV['API_KEY']}")
    end

    def self.single_history(o = {})
      age_group = o[:age_group]
      if o[:author]
        author = o[:author].to_s.gsub(/ /, '_')
      end

      if o[:publisher]
        publisher = o[:publisher].gsub(/ /, '_')
      end

      if o[:title]
        title = o[:title].gsub(/ /, '_')
      end

      if o[:response_format]
        response_format = '.' + o[:response_format]
      end

      if o[:age_group]
        age_group = o[:age_group].gsub(/ /, '_')
      end

      if o[:contributor]
        contributor = o[:contributor].gsub(/ /, '_')
      end

      if o[:isbn]
        isbn = o[:isbn]
      end

      if o[:price]
        price = o[:price]
      end

      HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/best-sellers/history#{response_format}?author=#{author}&publisher=#{publisher}&age-group=#{age_group}&title=#{title}&api-key=#{ENV['API_KEY']}")
    end

    def self.find_list_names
      HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/names?api-key=#{ENV['API_KEY']}")
    end

    def self.age_groups
      HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/age-groups?api-key=#{ENV['API_KEY']}")
    end

  end
end
