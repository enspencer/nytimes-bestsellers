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
     stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists//hardcover-fiction?api-key=abc123&offset=&sort-order=").to_return(body: fixture('get_list.json'))
    end

    it "fetches the specified list for the most recent week" do
      list = @client.get_list('hardcover-fiction')
      list = JSON.parse(list.body)
      # binding.pry
      expect(a_request(:get, "http://api.nytimes.com/svc/books/v2/lists//hardcover-fiction?api-key=abc123&offset=&sort-order=")).to have_been_made
      expect(list['results'][0]['list_name']).to eq "Hardcover Fiction"
    end
  end

  describe '#search_list' do
    before do
      stub_request(:get, "http://api.nytimes.com/svc/books/v2/lists?list-name=hardcover-nonfiction&api-key=abc123").to_return(body: fixture('search_list.json'))
    end

    it "searches the specified list by optional parameters" do
    end

  end



end