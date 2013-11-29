require 'spec_helper'
require 'pry'

describe Bestsellers::List do
  before do
    @client = Bestsellers::List.new
    @client.configure do |config|
      config.api_key = "abc123"
    end
  end

  describe '#get_list' do
    before do
     stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists/hardcover-fiction?api-key=abc123").to_return(body: fixture('get_list.json'))
    end

    it "fetches the specified list for the most recent week" do
      list = @client.get_list('hardcover fiction')
      list = JSON.parse(list.body)
      expect(a_request(:get, "http://api.nytimes.com/svc/books/v2/lists/hardcover-fiction?api-key=abc123")).to have_been_made
      expect(list['results'][0]['list_name']).to eq "Hardcover Fiction"
    end
  end

describe '#get_list' do
    before do
     stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists/2013-11-27/hardcover-fiction?api-key=abc123").to_return(body: fixture('get_list.json'))
    end

  it "fetches the specified list for the specified week" do
      list = @client.get_list('hardcover-fiction', date: '2013-11-27')
      list = JSON.parse(list.body)
      expect(a_request(:get, "http://api.nytimes.com/svc/books/v2/lists/2013-11-27/hardcover-fiction?api-key=abc123")).to have_been_made
      expect(list['results'][0]['list_name']).to eq "Hardcover Fiction"
    end
  end

  describe '#search_list' do
    before do
      stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists?api-key=abc123&date=2013-11-27&list-name=hardcover-nonfiction").to_return(body: fixture('search_list.json'))
    end

    it "searches the specified list by optional parameters" do
      list = @client.search_list('hardcover-nonfiction', date: '2013-11-27')
      list = JSON.parse(list.body)
      expect(a_request(:get, "http://api.nytimes.com/svc/books/v2/lists?api-key=abc123&date=2013-11-27&list-name=hardcover-nonfiction")).to have_been_made
      expect(list['results'][0]['list_name']).to eq "Hardcover Nonfiction"
    end

  end

  describe '#search_list' do

    before do
      stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists?list-name=hardcover-nonfiction&date=2013-11-27&published-date=2013-11-27&api-key=abc123").to_return(body: fixture('published_search.json'))
    end
   
   it "should search from published_date" do
    today = '2013-11-27'
    date = '2013-11-27'
     list = @client.search_list('hardcover-nonfiction', published_date: "#{today}", date: "#{date}")
     expect(a_request(:get, "http://api.nytimes.com/svc/books/v2/lists?list-name=hardcover-nonfiction&date=2013-11-27&published-date=2013-11-27&api-key=abc123")).to have_been_made
   end
  end

  describe '#single_history' do
    before do
      stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists/best-sellers/history?author=maddow&api-key=abc123").to_return(body: fixture('single_history.json'))
    end

    it "returns the list history of a single bestseller" do
      list = @client.single_history(author: 'maddow')
      list = JSON.parse(list.body)
      expect(a_request(:get, "http://api.nytimes.com/svc/books/v2/lists/best-sellers/history?author=maddow&api-key=abc123")).to have_been_made
      expect(list['results'][0]['title']).to eq "DRIFT"
    end
  end

  describe '#bestseller_lists_overview' do
    before do
      stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists/overview?published_date=2011-01-16&api-key=abc123").to_return(body: fixture('overview.json'))
    end

    it "returns an overview of all lists for a specified date" do
      list = @client.bestseller_lists_overview(date: '2011-01-16')
      list = JSON.parse(list.body)
      expect(a_request(:get, "http://api.nytimes.com/svc/books/v2/lists/overview?published_date=2011-01-16&api-key=abc123")).to have_been_made
      expect(list['results']['published_date']).to eq "2011-01-16"
    end
  end

  describe '#age_groups' do
    before do
      stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists/age-groups?api-key=abc123").to_return(body: fixture('age_groups.json'))
    end

    it "returns all age groups that books can take" do
      list = @client.age_groups
      list = JSON.parse(list.body)
      expect(a_request(:get, "http://api.nytimes.com/svc/books/v2/lists/age-groups?api-key=abc123")).to have_been_made
      expect(list['results'][0]['age_group']).to eq "Ages 1 to 5"
      expect(list['results'][3]['age_group']).to eq "Ages 10 to 14"
    end
  end

  describe '#find_list_names' do
    before do
      stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists/names?api-key=abc123").to_return(body: fixture('list_names.json'))
    end

    it "returns all the names of bestseller lists" do
      list = @client.find_list_names
      list = JSON.parse(list.body)
      expect(a_request(:get, "http://api.nytimes.com/svc/books/v2/lists/names?api-key=abc123")).to have_been_made
      expect(list['results'][0]['list_name']).to eq "Combined Print and E-Book Fiction"
      expect(list['results'][3]['list_name']).to eq "Hardcover Nonfiction"
    end
  end



end