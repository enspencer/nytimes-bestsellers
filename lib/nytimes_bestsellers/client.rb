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

    def get_list(list_name, o = {})
      # enter a list, optional: enter offset, sort_by, sort_order, response_format
      url = "http://api.nytimes.com/svc/books/v2/lists"

      if o[:date]
        date = o[:date]
        url << "/#{date}"
      end

      url << "/#{list_name}"

      if o[:response_format]
        response_format = '.' + o[:response_format] + "?"
        url << response_format
      else
        url << "?"
      end

      if o[:offset]
        offset = o[:offset].to_s
        url << "&offset=#{offset}"
      end

      if o[:sort_by]
        sort_by = o[:sort_by]
        url << "&sort-by=#{sort_by}"
      end

      if o[:sort_order] 
        sort_order = o[:sort_order]
        url << "&sort-order=#{sort_order}"
      end

      url << "&api-key=#{api_key}"

      HTTParty.get(url)
    end

    def search_list(list_name, o = {})

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

      url << "&api-key=#{api_key}"

      HTTParty.get(url)
    end

    def bestseller_lists_overview(o = {})
      date = (Date.parse o[:date] || Date.today).strftime('%Y-%m-%e')

      HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/overview?published_date=#{date}&api-key=#{api_key}")
    end

    def single_history(o = {})
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

      HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/best-sellers/history#{response_format}?author=#{author}&publisher=#{publisher}&age-group=#{age_group}&title=#{title}&api-key=#{api_key}")
    end

    def find_list_names
      HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/names?api-key=#{api_key}")
    end

    def age_groups
      HTTParty.get("http://api.nytimes.com/svc/books/v2/lists/age-groups?api-key=#{api_key}")
    end

  end
end
