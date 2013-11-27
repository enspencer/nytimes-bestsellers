require 'json'
require 'httparty'
require 'pry'
require_relative 'configuration'

module Bestsellers

  class List
    
    include Bestsellers::Configuration
    include HTTParty

    BOOKS_URL= "http://api.nytimes.com/svc/books/v2/lists"

    def initialize
      reset
    end

    def set_urlparam(url, name, options)
      return unless options[name]
      url << "&#{name.to_s.gsub('_','-')}=#{options[name]}"

      # url << "&bestsellers-date=#{bestsellers_date}"
     end

    def get_list(list_name, o = {})
      url = BOOKS_URL

      if o[:date]
        date = o[:date]
        url << "/#{date}"
      end
      
      url << "/#{list_name}"

      if o[:response_format]
        response_format = '.' + o[:response_format] + "?"
        url << "#{response_format}"
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

      url = BOOKS_URL + "?list-name=#{list_name}"

      date = if o[:date]
        Date.parse(o[:date]) 
      else
        Date.today
      end.strftime('%Y-%m-%e')
      # date = (Date.parse o[:date] || Date.today).strftime('%Y-%m-%e')
      # date = Date.today.strftime('%Y-%m-%e')
      url << "&date=#{date}"

      if o[:isbn]
        isbn = o[:isbn]
        url << "&isbn=#{isbn}"
      end

      [:published_date, :rank, :rank_last_week, :weeks_on_list].each do |thing|
        set_urlparam(url, thing, o)
      end
      # set_urlparam(url, :published_date, o)
      # set_urlparam(url, :rank, o)

      # if o[:published_date]
      #   published_date = o[:published_date]
      #   url << "&published-date=#{published_date}"
      # end

      # if o[:rank]
      #   rank = o[:rank]
      #   url << "&rank=#{rank}"
      # end

      # if o[:rank_last_week]
      #   rank_last_week = o[:rank_last_week]
      #   url << "&rank-last-week=#{rank_last_week}"
      # end

      # if o[:weeks_on_list]
      #   weeks_on_list = o[:weeks_on_list]
      #   url << "&weeks-on-list=#{weeks_on_list}"
      # end

      if o[:response_format]
        response_format = '.' + o[:response_format]
      end

      url << "&api-key=#{api_key}"

     HTTParty.get(url)
    end

    def bestseller_lists_overview(o = {})
      date = (Date.parse o[:date] || Date.today).strftime('%Y-%m-%e')

      HTTParty.get(BOOKS_URL + "/overview?published_date=#{date}&api-key=#{api_key}")
    end

    def single_history(o = {})

      url = BOOKS_URL + "/best-sellers/history"

      if o[:response_format]
        response_format = '.' + o[:response_format]
        url << "#{response_format}"
      end

      url << "?"

      if o[:author]
        author = o[:author].to_s.gsub(/ /, '_')
        url << "&author=#{author}"
      end

      if o[:publisher]
        publisher = o[:publisher].gsub(/ /, '_')
        url << "&publisher=#{publisher}"
      end

      if o[:title]
        title = o[:title].gsub(/ /, '_')
        url << "&title=#{title}"
      end

      if o[:age_group]
        age_group = o[:age_group].gsub(/ /, '_')
        url << "&age-group=#{age_group}"
      end

      if o[:contributor]
        contributor = o[:contributor].gsub(/ /, '_')
        url << "&contributor=#{contributor}"
      end

      if o[:isbn]
        isbn = o[:isbn]
        url << "&isbn=#{isbn}"
      end

      if o[:price]
        price = o[:price]
        url << "&price=#{price}"
      end

      url << "&api-key=#{api_key}"

      HTTParty.get(url)
    end

    def find_list_names
      HTTParty.get(BOOKS_URL + "/names?api-key=#{api_key}")
    end

    def age_groups
      HTTParty.get(BOOKS_URL + "/age-groups?api-key=#{api_key}")
    end

  end
end
