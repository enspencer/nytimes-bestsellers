require 'spec_helper'

describe Bestsellers do
  describe '.new' do
    it "returns a Bestsellers::List" do
      expect(Bestsellers.new).to be_a Bestsellers::List
    end
  end

  describe ".configure" do
    it "sets api_key" do
      Bestsellers.configure do |config|
        config.api_key = "secret"
      end

      expect(Bestsellers.api_key).to eq "secret"
    end
  end
end