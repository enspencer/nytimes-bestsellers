require 'json'
require 'httparty'

module Bestsellers

  class List
    include HTTParty
    def initialize
      @api_key = ::Bestsellers.configuration.api_key
      @lists_url = ::Bestsellers.configuration.lists_url
    end

    def set_urlparam(url, name, options)
      return unless options[name]
      url << "&#{name.to_s.gsub('_','-')}=#{options[name].gsub(/ /, '-')}"
     end

    def get_list(list_name, o = {})
      url = @lists_url.clone

      if o[:date]
        date = o[:date]
        url << "/#{date}"
      end
      
      url << "/#{list_name.gsub(/ /, '-')}?"

      [:offset, :sort_by, :sort_order].each do |thing|
        set_urlparam(url, thing, o)
      end

      url << "&api-key=#{@api_key}"

      HTTParty.get(url)
    end

    def search_list(list_name, o = {})

      url = @lists_url.clone + "?list-name=#{list_name.gsub(/ /, '-')}"

      date = if o[:date]
        Date.parse(o[:date]) 
      else
        Date.today
      end.strftime('%Y-%m-%e')
      url << "&date=#{date}"

      [:isbn, :published_date, :rank, :rank_last_week, :weeks_on_list, :offset, :sort_by, :sort_order].each do |thing|
        set_urlparam(url, thing, o)
      end

      url << "&api-key=#{@api_key}"

     HTTParty.get(url)
    end

    def bestseller_lists_overview(o = {})
      date = (Date.parse o[:date] || Date.today).strftime('%Y-%m-%e')

      HTTParty.get(@lists_url + "/overview?published_date=#{date}&api-key=#{@api_key}")
    end

    def single_history(o = {})

      url = @lists_url.clone + "/best-sellers/history"

      url << "?"

      [:author, :publisher, :title, :age_group, :contributor, :isbn, :price, :sort_by, :sort_order].each do |thing|
        set_urlparam(url, thing, o)
      end

      url << "&api-key=#{@api_key}"

      HTTParty.get(url)
    end

    def find_list_names
      HTTParty.get(@lists_url + "/names?api-key=#{@api_key}")
    end

    def age_groups
      HTTParty.get(@lists_url + "/age-groups?api-key=#{@api_key}")
    end

  end
end
