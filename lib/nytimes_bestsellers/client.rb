require 'json'
require 'httparty'
require 'pry'
require_relative 'configuration'

module Bestsellers

  class List
    
    include Bestsellers::Configuration
    include HTTParty

    BOOKS_URL = "http://api.nytimes.com/svc/books/v2/lists"
    BOOKS_URL

    def initialize
      reset
    end

    def set_urlparam(url, name, options)
      return unless options[name]
      url << "&#{name.to_s.gsub('_','-')}=#{options[name]}"
     end

    def get_list(list_name, o = {})
      url = BOOKS_URL.clone

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

      [:offset, :sort_by, :sort_order].each do |thing|
        set_urlparam(url, thing, o)
      end

      url << "&api-key=#{api_key}"

      HTTParty.get(url)
    end

    def search_list(list_name, o = {})

      url = BOOKS_URL.clone + "?list-name=#{list_name}"

      date = if o[:date]
        Date.parse(o[:date]) 
      else
        Date.today
      end.strftime('%Y-%m-%e')
      url << "&date=#{date}"

      [:isbn, :published_date, :rank, :rank_last_week, :weeks_on_list].each do |thing|
        set_urlparam(url, thing, o)
      end

      if o[:response_format]
        response_format = '.' + o[:response_format]
        url << "#{response_format}"
      end

      url << "&api-key=#{api_key}"

     HTTParty.get(url)
    end

    def bestseller_lists_overview(o = {})
      date = (Date.parse o[:date] || Date.today).strftime('%Y-%m-%e')

      HTTParty.get(BOOKS_URL + "/overview?published_date=#{date}&api-key=#{api_key}")
    end

    def single_history(o = {})

      url = BOOKS_URL.clone + "/best-sellers/history"

      if o[:response_format]
        response_format = '.' + o[:response_format]
        url << "#{response_format}"
      end

      url << "?"

      [:author, :publisher, :title, :age_group, :contributor, :isbn, :price].each do |thing|
        set_urlparam(url, thing, o)
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
